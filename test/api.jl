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

    # if a measure does not overload `consumes_multiple_observations` but really does, then
    # `meausurements` should nevertheless have the expected behavior:
    badly_implemented_rms(yhat, y) = (yhat - y).^2 |> mean |> sqrt
    μ = badly_implemented_rms([4, 5], [1, 1])
    @test measurements(badly_implemented_rms, [4, 5], [1, 1]) ≈ [μ, μ]
end

true
