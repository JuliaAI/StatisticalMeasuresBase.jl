# # ABSTRACT TYPES

"""
    Wrapper{M}

Abstract type for measure wrappers. Here `M` is the atomic measure type.

"""
abstract type Wrapper{M} end


# # VALUE TYPES

# for the `orientation` trait:
abstract type Orientation end
struct Score <: Orientation end
struct Loss <: Orientation end
struct Unoriented <: Orientation end

# for the `external_aggregation_mode` trait and the dispatch of the `aggregate` method:
"""
     $API.AggregationMode

Abstract type for modes of aggregating weighted or unweighted measurements. An aggregation
mode is one of the following concrete instances of this type (when unspecified, weights
are unit weights):

- `Mean()`: Compute the mean value of the weighted measurements. Equivalently, compute the
  usual [weighted mean](https://en.wikipedia.org/wiki/Arithmetic_mean) and multiply by the
  average weight. To get a true weighted mean, re-scale weights to average one, or use
  `IMean()` instead.

- `Sum()`: Compute the usual weighted sum.

- `RootMean()`: Compute the squares of all measurements, compute the weighted `Mean()` of
  these, and apply the square root to the result.

- `RootMean(p)` for some real `p > 0`: Compute the obvious generalization of `RootMean()`
  with `RootMean() = RootMean(2)`.

- `IMean()`: Compute the usual [weighted
  mean](https://en.wikipedia.org/wiki/Arithmetic_mean), which is insensitive to weight
  rescaling.

"""
abstract type AggregationMode end

"""
    Mean

$DOC_AGGREGATION_MODE

"""
struct Mean <: AggregationMode end

"""
    IMean

$DOC_AGGREGATION_MODE

"""
struct IMean <: AggregationMode end
"""
    Sum

$DOC_AGGREGATION_MODE

"""
struct Sum <: AggregationMode end
"""
    RootMean

$DOC_AGGREGATION_MODE

"""
struct RootMean{T<:Real} <: AggregationMode
    p::T
    function RootMean(p::S) where S
        p > 0 || throw(ERR_ROOT_MEAN)
        p == 1 && Mean()
        new{S}(p)
    end
end
RootMean() = RootMean(2)
