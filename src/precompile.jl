@setup_workload begin
    f(yhat, y) = abs(yhat - y)
    f(1.0, 2.0)
    f2(yhat, y) = 1 - 2*(yhat == y)
    f2('a', 'b')
    y = rand(2, 3)
    weights = rand(3)
    class_weights = Dict('a'=> 2, 'b'=> 3)
    y2 = CategoricalArrays.categorical(collect("aba"))
    @compile_workload begin
        measure = f |>
            supports_missings_measure |>
            robust_measure |>
            multimeasure |>
            multimeasure |>
            fussy_measure
        measure(y, y, weights)
        measurements(measure, y, y)
        measure2 = f2 |>
            supports_missings_measure |>
            robust_measure |>
            multimeasure |>
            fussy_measure
        measure2(y2, y2)
        measure2(y2, y2, weights, class_weights)
        measurements(measure2, y2, y2, class_weights)
    end
end
