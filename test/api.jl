pool = [-0.5, 0.5, 0.7, 0.2, -0.4]
N = 10
y = rand(pool, N)
yhat = rand(pool, N)
w = 10:10:10N

@testset "fallback for measurements" begin
    measure = LPLossOnScalars()
    measurements(measure, 2.3, 3.4) == LPLossOnScalars()(2.3, 3.4)
    measure = MeanAbsoluteError()
    measurements(measure, yhat, y) == fill(measure(yhat, y), N)
end

true
