external_aggregation_mode(m::AggregationMode) = m

# # NORMAL AGGREGATION

"""
    aggregate(itr; weights=nothing, mode=Mean(), skipnan=false)

Aggregate the values generated by the iterator, `itr`, using the specified aggregation
`mode` and optionally specified numerical `weights`.

Any `missing` values in `itr` are skipped before aggregation, but will still count towards
normalization factors. So, if the return type has a zero, it's as if we replace the
`missing`s with zeros.

The values to be aggregated must share a type for which `+`, `*` `/` and `^` (`RootMean`
case) are defined, or can be dictionaries whose value-type is so equipped.


# Keyword options

- `weights=nothing`: An iterator with a `length`, generating `Real` elements, or `nothing`

- `mode=Mean()`: Options include `Mean()` and `Sum()`; see
  [`$API.AggregationMode`](@ref) for all options and their
  meanings. $DOC_MEAN

- `skipnan=false`: Whether to skip `NaN` values in addition to `missing` values

- `aggregate=true`: If `false` then `itr` is just multiplied by any specified weights, and
  collected.

# Example

Suppose a 3-fold cross-validation algorithm delivers root mean squared errors given by
`errors` below, and that the folds have the specified `sizes`. Then `μ` below is the
appropriate error aggregate.

```julia
errors = [0.1, 0.2, 0.3]
sizes = [200, 200, 150]
weights = 3*sizes/sum(sizes)
@assert mean(weights) ≈ 1
μ = aggregate(errors; weights, mode=RootMean())
@assert μ ≈ (200*0.1^2 + 200*0.2^2 + 150*0.3^2)/550 |> sqrt
```

---

    aggregate(f, itr; options...)

Instead, aggregate the results of broadcasting `f` over `itr`. Weight multiplication
is fused with the broadcasting operation, so this method is more efficient than separately
broadcasting, weighting, and aggregating.

This method has the same keyword `options` as above.

# Examples

```julia
itr = [(1, 2), (2, 3), (4, 3)]

julia> aggregate(t -> abs(t[1] - t[2]), itr, weights=[10, 20, 30], mode=Sum())
60
```

"""
function aggregate(args...; weights=nothing, mode=Mean(), skipnan=false)
    _mode = external_aggregation_mode(mode)
    measurements, normalizer = measurements_plus(_mode, args..., weights)
    finish(measurements, normalizer, _mode, skipnan, Val(true))
end

"""
    weighted([f, ] itr; weights=nothing, mode=Mean(), skipnan=false)

This method takes the same arguments and keyword arguments as [`aggregate`](@ref) but only
multiplies the iterator by any specified weights and collects.  In the special case
`mode=RootMean(p)`, the weights are first replaced by their `p`th roots, for consistency
with how aggregation works in that case.

See also [`aggregate`](@ref)

"""
function weighted(args...; weights=nothing, mode=Mean(), skipnan=false)
    _mode = external_aggregation_mode(mode)
    measurements, normalizer = measurements_plus(_mode, args..., weights)
    finish(measurements, normalizer, _mode, skipnan, Val(false))
end

_skip(skipnan) = itr -> skipinvalid(itr; skipnan)
_nan(measurements) = nonmissingtype(eltype(measurements))(NaN)

encode(x) = x
encode(x::AbstractDict{K,V}) where {K,V<:Number} = ArithmeticDict(x)
decode(x) = x
decode(x::ArithmeticDict) = LittleDict(x)

# Sum:
measurements_plus(::Sum, f, itr, weights) = (weights .* encode.(f.(itr)), nothing)
measurements_plus(::Sum, f, itr, ::Nothing) = (encode.(f.(itr)), nothing)
measurements_plus(::Sum, itr, weights) = (weights .* encode.(itr), nothing)
measurements_plus(::Sum, itr, ::Nothing) = (encode.(itr), nothing)
finish(measurements, normalizer, ::Sum, skipnan, ::Val{true}) =
    _skip(skipnan)(measurements) |> sum |> decode

# IMean:
measurements_plus(::IMean, f, itr, weights) =
    (weights .* encode.(f.(itr)), sum(weights))
measurements_plus(::IMean, f, itr, ::Nothing) = (encode.(f.(itr)), length(itr))
measurements_plus(::IMean, itr, weights) = (weights .* encode.(itr), sum(weights))
measurements_plus(::IMean, itr, ::Nothing) =(encode.(itr), length(itr))
function finish(measurements, normalizer, ::IMean, skipnan, ::Val{true})
    isempty(measurements) && return _nan(measurements)
    sum(_skip(skipnan)(measurements))/normalizer |> decode
end

# Mean:
measurements_plus(::Mean, f, itr, weights) = (weights .* encode.(f.(itr)), length(itr))
measurements_plus(::Mean, f, itr, ::Nothing) = (encode.(f.(itr)), length(itr))
measurements_plus(::Mean, itr, weights) = (weights .* encode.(itr), length(itr))
measurements_plus(::Mean, itr, ::Nothing) =(encode.(itr), length(itr))
function finish(measurements, normalizer, ::Mean, skipnan, ::Val{true})
    isempty(measurements) && return _nan(measurements)
    sum(_skip(skipnan)(measurements))/normalizer |> decode
end

# RootMean:
measurements_plus(mode::RootMean, f, itr, weights) =
    (weights .* encode.(f.(itr)) .^ mode.p, length(itr))
measurements_plus(mode::RootMean, f, itr, ::Nothing) =
    (encode.(f.(itr)) .^ mode.p, length(itr))
measurements_plus(mode::RootMean, itr, weights) =
    (weights .* (encode.(itr) .^ mode.p), length(itr))
measurements_plus(mode::RootMean, itr, ::Nothing) =
    (encode.(itr) .^ mode.p, length(itr))
function finish(measurements, normalizer, mode::RootMean, skipnan, ::Val{true})
    isempty(measurements) && return _nan(measurements)
    (sum(_skip(skipnan)(measurements))/normalizer)^(1/mode.p) |> decode
end

finish(measurements, normalizer, mode, skipnan, ::Val{false}) =
    decode.(collect(measurements))
finish(measurements, normalizer, mode::RootMean, skipnan, ::Val{false}) =
    decode.(measurements .^ (1/mode.p))


# TODO: Possibly explicit @simd loop could increase performance