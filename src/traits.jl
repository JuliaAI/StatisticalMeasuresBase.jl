#todo MLJBase is calling this MODEL_TRAITS
#todo very breaking: `ground_truth_scitype` is different from `observation_scitype` which is
# removed.
#todo supports_class_weights fallback different from MLJBase behavior
#todo i remove is_measure_trait
#todo removed info
#todo MLJBase will need to define as deprecated "derived" traits: :prediction_type,
#:reports_each_observation, :aggregation

#todo MLJBase will break the following, which are to be removed or no longer implemented
#for measures: :is_feature_dependent, :docstring, :distribution_type

# # OVERLOADABLE TRAITS

# ## is_measure

"""
    $API.is_measure(m)

Returns `true` if `m` is a measure, as defined below.

An object `m` has *measure calling syntax* if it is a function or other callable with the
following signatures:

```julia
m(ŷ, y)
m(ŷ, y, weights)
m(ŷ, y, class_weights::AbstractDict)
m(ŷ, y, weights, class_weights)
```

Only the first signature is obligatory.

Of course `m` could be an instance of some type with parameters.

If, additionally, `m` returns an (aggregated) measurement, where `y` has the
interpretation of one or more ground truth *target* observations, and `ŷ` corresponding to
one or more predictions or *proxies* of predictions (such as probability distributions),
then `m` is a *measure*.  The terms "target" and "proxy" are used here in the sense of
[LearnAPI.jl](https://juliaai.github.io/LearnAPI.jl/dev/).

What qualifies as a "measurement" is not formally defined, but this is typically a `Real`
number; other use-cases are matrices (e.g., confusion matrices) and dictionaries (e.g.,
mutli-class true positive counts).

# Arguments

For `m` to be a valid measure, it will handle arguments of one of the following forms:

- `y` is either:

  - a single ground truth observation of some variable, the \"target\", or

  - an object implementing the `getobs`/`numobs` interface in MLUtils.jl, and consisting
    of multiple target observations

- `ŷ` is correspondingly:

  - a single target prediction or proxy for a prediction, such as a probability
    distribution, or

  - an object implementing the `getobs`/`numobs` interface in MLUtils.jl, and consisting
    of multiple target (proxy) predictions, with `numobs(ŷ) == numobs(y)` - *or* is a
    single object, such as a joint probability distribution. The latter case should be
    clarified by an appropriate [`$API.kind_of_proxy(measure)`](@ref) declaration.

- `weights`, applying only in the multiple observation case, is an arbitrary iterable
  collection with a `length`, generating `n` `Real` elements, where `n ≥
  MLUtils.numobs(y)`.

- `class_weights` is an arbitrary `AbstractDict` with `Real` values, whose keys include
  all possible observations in `y`.

"""
is_measure(::Wrapper) = true
is_measure(::Any) =false


# ## consumes_multiple_observations

"""
    $API.consumes_multiple_observations(measure)

Returns `true` if the ground truth target `y` appearing in calls like `measure(ŷ, y)` is
expected to support the MLUtils.jl `getobs`/`numobs` interface, which includes all arrays
and some tables.

If `$API.kind_of_proxy(measure) <: LearnAPI.IID` (the typical case) then a `true` value
for this measure trait also implies `ŷ` is expected to be an MLUtils.jl data container
with the same number of observations as `y`.

# New implementations

Overload this trait for a new measure type that consumes multiple observations, unless it
has been constructed using `multimeaure` or is an $API.jl wrap thereof. The general
fallback returns `false` but it is `true` for any [`multimeasure`](@ref), and the value is
propagated by other wrappers.

"""
consumes_multiple_observations(::Any) =false


# ## can_report_unaggregated

"""
    $API.can_report_unaggregated(measure)

Returns `true` if `measure` can report individual measurements, one per ground truth
observation. Such unaggregated measurements are obtained using [`measurements`](@ref)
instead of directly calling the measure on data.

If the method returns `false`, `measurements` returns the single aggregated measurement
returned by calling the measure on data, but repeated once for each ground truth
observation.

# New implementations

Overloading the trait is optional and it is typically not overloaded. The general fallback
returns `false` but it is `true` for any [`multimeasure`](@ref), and the value is
propagated by other wrappers.

"""
can_report_unaggregated(measure) = false


# ## kind_of_proxy

"""
    $API.kind_of_proxy(measure)

Return the kind of proxy `ŷ` for target predictions expected in calls of the form
`measure(ŷ, y, args...; kwargs...)`.

Typical return values are `LearnAPI.LiteralTarget()`, when `ŷ` is expected to have the
same form as `ŷ`, or `LearnAPI.Distribution()`, when the observations in `ŷ` are expected
to represent probability density/mass functions. For other kinds of proxy, see the
[LearnAPI.jl](https://juliaai.github.io/LearnAPI.jl/dev/) documentation.

# New implementations

Optional but strongly recommended. The return value must be a subtype of
`LearnAPI.KindOfProxy` from the package LearnAPI.jl.

The fallback returns `nothing`.

"""
kind_of_proxy(measure) = nothing


# ## observation_scitype

"""
    $API.observation_scitype(measure)

Returns an upper bound on the allowed scientific type of a single ground truth observation
passed to `measure`. For more on scientific types, see the ScientificTypes.jl
documentation.

Specifically, if the `scitype` of every element of `observations =
[MLUtils.eachobs(y)...]` is bounded by the method value, then that guarantees that
`measure(ŷ, y; args...; kwargs...)` will succeed, assuming `y` is suitably
compatible with the other arguments.

# Support for tabular data

If [`$API.can_consume_tables(measure)`](@ref) is `true`, then `y` can additionally be any
table, so long as `vec(collect(row))` makes sense for every `row` in `observations`
(e.g., `y` is a `DataFrame`) and is bounded by the scitype returned by
`observation_scitype(measure)`.

All the behavior outlined above assumes
[`$API.consumes_multiple_observations(measure)`](@ref) is `true`. Otherwise, the return
value has no meaning.



# New implementations

Optional but strongly recommended for measure than consume multiple observations. The
fallback returns `Union{}`.

Examples of return values are `Union{Finite,Missing}`, for `CategoricalValue` observations
with possible `missing` values, or `AbstractArray{<:Infinite}`, for observations that are
arrays with either `Integer` or `AbstractFloat` eltype. $DOC_SCITYPES.

"""
observation_scitype(measure) = Union{}


# ## can_consume_tables

"""
    $API.can_consume_tables(measure)

Return `true` if `y` and `ŷ` in a call like `measure(ŷ, y)` can be a certain kind of table
(e.g., a `DataFrame`). See [`$API.observation_scitype`](@ref) for details.

# New implementations

Optional. The main use case is measures of the form [`multimeasure`](@ref)`(atom,
transform=vec∘collect)`, where `atom` is a measure consuming vectors. See
[`multimeasure`](@ref) for an example. For such measures the trait can be overloaded to
return `true`.

The fallback returns `false`.

"""
can_consume_tables(measure) =  false


# ## supports_weights

"""
    $API.supports_weights(measure)

Return `true` if the measure supports per-observation weights, which must be
`AbstractVector{<:Real}`.

# New implementations

The fallback returns `false`. The trait is `true` for all [`multimeasure`](@ref)s.

"""
supports_weights(measure) = false


# ## supports_class_weights

"""
    $API.supports_class_weights(measure)

Return `true` if the measure supports class weights, which must be
dictionaries of `Real` values keyed on all possible values of targets `y` passed to the
measure.

# New implementations

The fallback returns `false`. The trait is `true` for all [`multimeasure`](@ref)s.

"""
supports_class_weights(measure) = false


# ## orientation

"""
    $API.orientation(measure)

Returns:

- `StatisticalMeasuresBase.Score()`, if `measure` is likely the basis of optimizations in
  which the measure value is always *maximized*

- `StatisticalMeasuresBase.Loss()`, if `measure` is likely the basis of optimizations in
  which the  measure value is always *minimized*

- `StatisticalMeasuresBase.Unoriented()`, in any other case

# New implementations

This trait should be overloaded for measures likely to be used in optimization.

The fallback returns `Unoriented()`.

"""
orientation(measure) = Unoriented()


# ## external_aggregation_mode

"""
    $API.external_aggregation_mode(measure)

Returns the preferred mode for aggregating measurements generated by applications of the
measure on multiple sets of data. This can be useful to know when aggregating separate
measurements in a cross-validation scheme. It is also the default aggregation mode used
when wrapping a measure using [`multimeasure`](@ref).

See also [`aggregate`](@ref), [`multimeasure`](@ref)

# New implementations

This optional trait has a fallback returning `Mean()`. Possible values are instances of
subtypes of [`$API.AggregationMode`](@ref).

"""
external_aggregation_mode(measure) = Mean()


# ## human_name

"""
    $API.human_name(measure)

A human-readable string representation of `typeof(measure)`. Primarily intended for
auto-generation of documentation.

# New implementations

Optional. A fallback takes the type name, inserts spaces and removes capitalization. For
example, `FScore` becomes `"f score"`. Better might be to overload the trait
    to return `"F-score"`.

"""
human_name(measure) = snakecase(string(typename(measure)), delim=' ')

const OVERLOADABLE_TRAIT_FUNCTIONS = [# -- fallback --
    is_measure,                       # false
    consumes_multiple_observations,   # false;
    can_report_unaggregated,          # false
    kind_of_proxy,                    # nothing
    observation_scitype,              # Union{}
    can_consume_tables,               # false
    supports_weights,                 # false
    supports_class_weights,           # false
    orientation,                      # Unoriented()
    external_aggregation_mode,        # Mean()
    human_name,                       # type name as string, kinda
]
const OVERLOADABLE_TRAITS = Symbol.(string.(OVERLOADABLE_TRAIT_FUNCTIONS))
const METADATA_TRAIT_FUNCTIONS = setdiff(OVERLOADABLE_TRAIT_FUNCTIONS, [is_measure,])
const METADATA_TRAITS = Symbol.(string.(METADATA_TRAIT_FUNCTIONS))

const OVERLOADABLE_TRAITS_LIST = join(string.(OVERLOADABLE_TRAITS), ", ")
