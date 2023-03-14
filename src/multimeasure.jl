ERR_UNSUPPORTED_WEIGHTS(measure) = ArgumentError(
    "The atomic measure, $measure, does not support weights. "
)

struct Multimeasure{M,W,A,T} <: Wrapper{M}
    atom::M          # atomic measure
    atomic_weights::W       # atomic weights
    mode::A          # aggregation mode
    skipnan::Bool
    transform::T
    function Multimeasure(
        atom::M,
        atomic_weights::W,
        mode::A,
        skipnan,
        transform::T,
        ) where {M,W,A,T}
        isnothing(atomic_weights) || supports_weights(atom) ||
            throw(ERR_UNSUPPORTED_WEIGHTS(atom))
        new{M,W,A,T}(atom, atomic_weights, mode, skipnan, transform)
    end
end

# forward propertynames from the atom, adding  `:atomic_weights` if not `nothing`:
Base.propertynames(measure::Multimeasure{<:Any,Nothing}) =
    propertynames(getfield(measure, :atom))
Base.propertynames(measure::Multimeasure) = unique((
    propertynames(getfield(measure, :atom))...,
    :atomic_weights,
))

Base.getproperty(measure::Multimeasure{<:Any,Nothing}, name::Symbol) =
    getproperty(getfield(measure, :atom), name)
function Base.getproperty(measure::Multimeasure, name::Symbol)
    name === :atomic_weights && return getfield(measure, :atomic_weights)
    getproperty(getfield(measure, :atom), name)
end

# private accessor functions:
atom(measure::Multimeasure) = getfield(measure, :atom)
atomic_weights(measure::Multimeasure) = getfield(measure, :atomic_weights)
mode(measure::Multimeasure) = getfield(measure, :mode)
skipnan(measure::Multimeasure) = getfield(measure, :skipnan)
transform(measure::Multimeasure) = getfield(measure, :transform)

"""
    $API.multimeasure(atomic_measure; options...)

Return a new measure, called a *multi-measure*, which, on a prediction-target pair `(ŷ,
y)`, broadcasts `atomic_measure` over `MLUtils.eachobs((ŷ, y))` and aggregates the
result. Here `ŷ` and `y` are necessarily objects implementing the MLUtils `getobs/numobs`
interface, such as arrays, and tables `X` for which `Tables.istable(X) == true`.

All multi-measures automatically support weights and class weights.

By default, aggregation is performed using the preferred mode for `atomic_measure`, i.e.,
`$API.external_aggregation_mode(atomic_measure)`. Internally, aggregation is performed
using the [`aggregate`](@ref) method.

Nested applications of `multimeasure` are useful for building measures that apply to
matrices and some tables ("multi-targets") as well as multidimensional arrays. See the
Advanced Examples below.

# Simple example

```julia
using StatisticalMeasuresBase

# define an atomic measure:
struct L2OnScalars
(::L2OnScalars)(ŷ, y) = (ŷ - y)^2

julia> $API.external_aggregation_mode(L2OnScalars())
Mean()

# define a multimeasure:
L2OnVectors() = $API.multimeasure(L2OnScalars())

y = [1, 2, 3]
ŷ = [7, 6, 5]
@assert L2OnVectors()(ŷ, y) ≈ (ŷ - y).^2 |> mean
```

# Keyword options

- `mode=$API.external_aggregation_mode(atomic_measure)`: mode for aggregating the results
  of broadcasting. Possible values include `Mean()` and `Sum()`. See
  [`AggregationMode`](@ref) for all options and their meanings. $DOC_MEAN.

- `transform=identity`: an optional transformation applied to observations in `y` and `ŷ`
  before passing to each `atomic_measure` call. A useful value is `vec∘collect` which is
  the identity on vectors, flattens arrays, and converts the observations of some tables
  (it's "rows") to vectors. See the example below.

- `atomic_weights=nothing`: the weights to be passed to the atomic measure, on each call
  to evaluate it on the pair `(transform(ŷᵢ), transform(yᵢ))`, for each `(ŷᵢ, yᵢ)` in
  `MLUtils.eachjobs(ŷ, y)`. Assumes `atomic_measure` supports weights.

- `skipnan=false`: whether to skip `NaN` values when aggregating (`missing` values are
  always skipped)

# Advanced examples

Building on `L2OnVectors` defined above:

```julia
# define measure for multi-dimensional arrays and some tables:
L2() = multimeasure(L2OnVectors(), transform=vec∘collect)

y = rand(3, 5, 100)
ŷ = rand(3, 5, 100)
weights = rand(100)
@assert L2()(ŷ, y, weights) ≈
   sum(vec(mean((ŷ - y).^2, dims=[1, 2])).*weights)/length(weights)

using Tables
y = rand(3, 100)
ŷ = rand(3, 100)
t = Tables.table(y') |> Tables.rowtable
t̂ = Tables.table(ŷ') |> Tables.rowtable
@assert L2()(t̂, t, weights) ≈
   sum(vec(mean((ŷ - y).^2, dims=1)).*weights)/length(weights)
```

!!! note

    The measure traits
    [`StatisticalMeasuresBase.observation_scitype(measure)`](@ref)
    (default=`Union{}`) and [`StatisticalMeasuresBase.can_consume_tables(measure)`](@ref)
    (default=`false`) are not forwarded from the atomic measure and must be explicitly
    overloaded for measures wrapped using `multimeasure`.

"""
multimeasure(
    atom;
    atomic_weights=nothing, # must implement `getobs`, eg abstract vector
    mode=external_aggregation_mode(atom),
    skipnan=false,
    transform=identity,
) = Multimeasure(atom, atomic_weights, mode, skipnan, transform)

multimeasure(
    atom,
    atomic_weights;
    mode=external_aggregation_mode(atom),
    skipnan=false,
) = Multimeasure(atom, atomic_weights, mode, skipnan, transform)

_slurp(x) = (x, )
_slurp(::Nothing) = ()

function call(measure::Multimeasure, ŷ, y, weight_args...)
    skipnan = StatisticalMeasuresBase.skipnan(measure)
    mode = StatisticalMeasuresBase.mode(measure)
    weights = CompositeWeights(y, weight_args...)
    atomic_wts = StatisticalMeasuresBase.atomic_weights(measure)
    aggregate(MLUtils.eachobs((ŷ, y)); weights, mode, skipnan) do (η̂, η)
        atom(measure)(transform(measure).((η̂, η))..., _slurp(atomic_wts)...)
    end
end

function measurements(measure::Multimeasure, ŷ, y, weight_args...)
    skipnan = StatisticalMeasuresBase.skipnan(measure)
    mode = StatisticalMeasuresBase.mode(measure)
    weights = CompositeWeights(y, weight_args...)
    atomic_wts = StatisticalMeasuresBase.atomic_weights(measure)
    weighted(MLUtils.eachobs((ŷ, y)); weights, mode, skipnan) do (η̂, η)
        atom(measure)(transform(measure).((η̂, η))..., _slurp(atomic_wts)...)
    end
end


# # TRAITS

consumes_multiple_observations(::Multimeasure) = true
can_report_unaggregated(::Multimeasure) = true
supports_weights(::Multimeasure) = true
supports_class_weights(::Multimeasure) = true
external_aggregation_mode(measure::Multimeasure) = mode(measure)

for trait in setdiff(OVERLOADABLE_TRAITS, [
    :consumes_multiple_observations,
    :can_report_unaggregated,
    :supports_weights,
    :supports_class_weights,
    :observation_scitype, # not overloaded
    :can_consume_tables,  # not overloaded
    :external_aggregation_mode,
    ])
    quote
        $trait(measure::Multimeasure) = $trait(atom(measure))
    end |> eval
end


# # DISPLAY

Base.show(io::IO, measure::Multimeasure) =
    print(io, "multimeasure("*repr(unwrap(measure))*")")
Base.show(io::IO, mime::MIME"text/plain", measure::Multimeasure) =
    print(io, "multimeasure("*_repr_(unwrap(measure))*")")
