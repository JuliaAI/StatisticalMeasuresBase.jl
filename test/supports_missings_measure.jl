measure = API.supports_missings_measure(LPLossOnScalars())
rng = srng(123)

@testset "calling" begin
    @test ismissing(measure(1.0, missing))
    @test ismissing(measure(missing, 1.0))
    @test ismissing(measure(missing, missing))
    @test measure(1.0, 4.5) == lploss(1.0, 4.5)
end

atom = LPLossOnVectors()
measure = API.supports_missings_measure(atom)
y = [1 ,2, 3]
yhat = rand(rng, 3)
weights = rand(3)
class_weights = Dict(1=>rand(rng), 2=>rand(rng), 3=>rand(rng))

@testset "measurements" begin
    ms = measurements(measure, [1, missing, 2], [missing, 1, 2])
    @test ismissing(ms[1])
    @test ismissing(ms[2])
    @test !ismissing(ms[3])
    @test measurements(measure, yhat, y) ≈
        measurements(atom, yhat, y)
    @test measurements(measure, yhat, y, weights) ≈
        measurements(atom, yhat, y, weights)
    @test measurements(measure, yhat, y, class_weights) ≈
        measurements(atom, yhat, y, class_weights)
    @test measurements(measure, yhat, y, weights, class_weights) ≈
        measurements(atom, yhat, y, weights, class_weights)
end

atom = TraitTester(0)
measure =  supports_missings_measure(atom)

@testset "traits" begin
    for trait in setdiff(API.OVERLOADABLE_TRAITS, [:observation_scitype,])
        quote
            @test API.$trait(atom) == API.$trait(measure)
        end |> eval
    end
    @test API.observation_scitype(measure) ==
        Union{Missing,API.observation_scitype(atom)}
end

true
