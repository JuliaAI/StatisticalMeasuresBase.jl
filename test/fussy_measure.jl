y = categorical(["yes", "no", "no", "no"], ordered=true)
yhat = categorical(["yes", "no", "yes", "yes"], ordered=true)
weights = rand(4)
class_weights = Dict("no" => 1, "yes" => 2, "maybe" => 3)

@testset "constructor" begin
    @test_throws(
        API.ERR_UNSUPPORTED_BY_FUSSY,
        API.fussy_measure(LPLossOnScalars()),
    )
end

@testset "calling measure" begin

    m = API.fussy_measure(FalsePositive())

    @test_logs m(yhat, y, weights, class_weights)
    @test_logs m(yhat, y, class_weights)
    @test_logs m(yhat, y, weights)
    @test_logs m(yhat, y)

    yshort = y[1:end-1]
    wshort = weights[1:end-1]
    ywrong = categorical(["possibly", "no", "no", "no"], ordered=true)
    class_weights_short = Dict("yes" => 2, "maybe" => 3)
    @test_throws(
        API.ERR_DIMENSIONS(4, 3),
        m(yhat, yshort),
    )
    @test_throws(
        API.ERR_DIMENSIONS(4, 3),
        m(yhat, y, wshort),
    )
    @test_throws(
        API.ERR_POOL_ORDER,
        m(yhat, ywrong),
    )
    @test_throws(
        API.ERR_KEYSET,
        m(yhat, y, class_weights_short),
    )
end

@testset "with extra_check" begin
    extra(m, yhat, y, args...) = length(y) == 4 || throw(ArgumentError("bla"))
    m = API.fussy_measure(FalsePositive(), extra_check=extra)
    @test_logs m(yhat, y)
    @test_throws ArgumentError("bla") m(yhat[1:3], y[1:3])
end

# fussy_measure cannot wrap atoms for which `consumes_multipled_observations` is
# `false`:
atom = multimeasure(TraitTester(0))
measure =  fussy_measure(atom)

@testset "traits" begin
    for trait in API.OVERLOADABLE_TRAITS
        quote
            @test API.$trait(atom) == API.$trait(measure)
        end |> eval
    end
end
