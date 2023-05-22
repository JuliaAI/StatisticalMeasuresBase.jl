@testset "constructor" begin
    @test Measure(LPLoss()) === LPLoss()
    @test_throws API.ERR_NOT_CONVERTIBLE Measure(min)
end

(measure::Measure{typeof(min)})(yhat, y) = abs(API.unwrap(measure)(yhat, y))
API.is_measure(::Measure{typeof(min)}) = true

@testset "calling" begin
    measure = Measure(min)
    @test measure(2, -3) == 3
    @test measurements(measure, 2, -3) == [3,]
end

true
