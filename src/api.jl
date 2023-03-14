#todo note `check` is called `_check` in MLJBase, but not public
#todo the way class_weights are specified is breaking!
#todo change `w` -> `weights`

"""
    measurements(measure, ŷ, y[, weights, class_weights::AbstractDict])

Return a vector of measurements, one for each observation in `y`, rather than a single
aggregated measurement. Otherwise the behavior is the same as calling the measure directly
on data.

# New implementations

Overloading this trait is optional. A fallback returns the aggregated measure, repeated
`n` times, where `n = MLUtils.numobs(y)`.  It is not typically necessary to overload
`measurements` for wrapped measures.  All [`multimeasure`](@ref)s provide the obvious
fallback and other wrappers simply forward the `measurements` method of the atomic
measure. If overloading, use the following signatures:

    $API.measurements(measure::SomeMeasureType, ŷ, y)
    $API.measurements(measure::SomeMeasureType, ŷ, weights)
    $API.measurements(measure::SomeMeasureType, ŷ, class_weights::AbstractDict)
    $API.measurements(measure::SomeMeasureType, ŷ, weights, class_weights)

"""
function measurements(measure, yhat, y, args...)
    consumes_multiple_observations(measure) || return measure(yhat, y, args...)
    m = measure(yhat, y, args...)
    fill(m, MLUtils.numobs(y))
end
