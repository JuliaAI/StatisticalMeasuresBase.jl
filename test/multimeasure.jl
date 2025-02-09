l1(ηhat, η) = abs(ηhat - η)

struct MAEOnScalars end

@trait(
    MAEOnScalars,
    orientation = Loss(),
)

(measure::MAEOnScalars)(yhat, y) = l1(yhat, y)

MAEOnVectors() = API.multimeasure(MAEOnScalars(), mode=IMean())

@testset "constructor" begin
    atom = MAEOnScalars()
    @test_throws(
        API.ERR_UNSUPPORTED_WEIGHTS(atom),
        API.multimeasure(atom, atomic_weights=[1, 2, 3]),
    )
end

pool = [-0.5, 0.5, 0.7, 0.2, -0.4]
N = 10
y = rand(srng(), pool, N)
yhat = rand(srng(1), pool, N)
weights = rand(srng(2), N)
class_weights = Dict(pool[i] => sin(i)^2 for i in eachindex(pool))
weights2 = (class_weights[y[i]] for i in 1:N)

@testset "multimeasure with generic atom" begin
    measure = MAEOnVectors()
    @test measure(yhat, y) ≈ mean(abs.(y - yhat))
    @test measure(yhat, y, nothing) ≈ measure(yhat, y)
    @test measure(yhat, y, weights) ≈
        sum(abs.(y - yhat).*weights)/sum(weights)
    @test measure(yhat, y, class_weights) ≈
        sum(abs.(y - yhat).*weights2)/sum(weights2)
    @test measure(yhat, y, nothing, nothing) ≈
        measure(yhat, y)
    @test measure(yhat, y, nothing, class_weights) ≈
        measure(yhat, y, class_weights)
    @test measure(yhat, y, weights, class_weights) ≈
        sum(abs.(y - yhat).*weights.*weights2)/sum(weights.*weights2)
end

atom = MAEOnVectors()

# multitargets with 3 features per observation:
y = rand(srng(), pool, 3, N)
yhat = rand(srng(1), pool, 3, N)
y_table, yhat_table = Tables.rowtable.(Tables.table.((yhat', y')))

@testset "multimeasure with atomic weights and transform" begin
    MAE() = API.multimeasure(atom, transform=vec∘collect)

    # no atomic weights:
    measure = MAE()
    @test measure(yhat, y) ≈ mean(abs.(y - yhat))
    @test measure(yhat, y, nothing) ≈ measure(yhat, y)
    μ = measure(yhat, y, weights)
    @test only(mean(abs.(y - yhat), dims=1)*weights)/sum(weights) ≈ μ
    @test measure(yhat_table, y_table, weights) ≈ μ
    @test sum(weights.*[atom(yhat[:,i], y[:, i]) for i in 1:N])/sum(weights) ≈ μ

    # with atomic weights:
    atomic_wts = rand(srng(), 3)
    measure = API.multimeasure(atom, atomic_weights=atomic_wts, transform=vec∘collect)
    @test measure(yhat, y) ≈
        mean([atom(yhat[:,i], y[:, i], atomic_wts) for i in 1:N])
    @test measure(yhat, y, nothing) ≈ measure(yhat, y)
    μ = measure(yhat, y, weights)
    @test measure(yhat_table, y_table, weights) ≈ μ
    @test sum(weights.*[atom(yhat[:,i],  y[:, i], atomic_wts)
                        for i in 1:N])/sum(weights) ≈ μ
end

atom = TraitTester(0)
measure =  multimeasure(atom)

@testset "traits" begin
    for trait in setdiff(API.OVERLOADABLE_TRAITS, [
        :consumes_multiple_observations,
        :can_report_unaggregated,
        :supports_weights,
        :supports_class_weights,
        :observation_scitype,
        :can_consume_tables,
        ])
        quote
            @test API.$trait(atom) == API.$trait(measure)
        end |> eval

    end
    @test API.consumes_multiple_observations(measure)
    @test API.can_report_unaggregated(measure)
    @test API.supports_weights(measure)
    @test API.supports_class_weights(measure)
    # these are not overloaded by multimeasure, so get the global fallbacks:
    @test API.observation_scitype(measure) == Union{}
    @test !API.can_consume_tables(measure)
end

true
