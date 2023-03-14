# Tutorial

Read this tutorial to learn how to implement new measures using
StatisticalMeasuresBase.jl. Refer to [Implementing New Measures](@ref) and other sections
for technical details, bells and whistles.

The goal of this tutorial is to define a [Huber loss
function](https://en.wikipedia.org/wiki/Huber_loss), `HuberLoss(; delta=1)`, that consumes vectors
of real ground truth observations/predictions, with support for weights, class weights and
missing values; and a second measure `MultitargetHuberLoss(; delta=1)` that consumes matrices,
tables or multidimensional arrays. To do so requires only that we implement a single Huber
loss for scalars and apply appropriate measure [wrappers](@ref wrappers).

As we'll see, the most important wrapper to understand is the
[`multimeasure`](@ref) wrapper.

## The basics

Let's start by defining a scalar [Huber loss
function](https://en.wikipedia.org/wiki/Huber_loss):

```@example 42
valley(a, delta=1) = abs(a) <= delta ? a^2/2 : delta*(abs(a) - delta/2)
huber(ŷ, y, delta=1) = valley(ŷ - y, delta)
```

#### Huber loss type for scalar input

Since the Huber loss has a parameter, we create a struct, and make instances callable:

```@example 42
using StatisticalMeasuresBase
import StatisticalMeasuresBase as API

struct HuberLossOnScalars{T<:Real}
    delta::T
end
(measure::HuberLossOnScalars)(ŷ, y) = huber(ŷ, y, measure.delta)
API.is_measure(::HuberLossOnScalars) = true # recommended if `HuberLossOnScalars` is public-facing
```

```@example 42
measure = HuberLossOnScalars(0.5)
@assert measure(7, 4) == huber(7, 4, 0.5)
```

####  Huber loss for vector input

To get a Huber loss for vectors, we wrap the scalar measure using [`multimeasure`](@ref),
which broadcasts over `MLUtils.eachobs((ŷ, y))` in `call` invocations. We also
include a preliminary wrapping to support `missing` values:

```@example 42
HuberLoss(delta) =
    multimeasure(supports_missings_measure(HuberLossOnScalars(delta)))
HuberLoss(; delta=1) = HuberLoss(delta)
```

By default, a new measure has `Mean()` as its *external aggregation mode*, which you can
inspect using the trait
[`StatisticalMeasuresBase.external_aggregation_mode(measure)`](@ref). Wrappers, like
`support_missings_measure`, forward such traits to the wrapped measure. The
[`multimeasure`](@ref) wrapper uses [MLUtils.jl](https://github.com/JuliaML/MLUtils.jl)'s
`eachobs` method to broadcast the atomic measure over oberservations and, by default,
aggregates the result using the atomic measure's aggregation mode.

#### Demonstration

```@example 42
using Statistics
ŷ = [1, 2, missing]
y = [7, 4, 6]
weights = [1, 3, 2]
class_weights = Dict(7=>3.0, 4=>4.0, 6=>2.0)

wts = weights .* (class_weights[η] for η in y)
@assert HuberLoss(1)(ŷ, y, weights, class_weights) ≈
    sum(wts[1:2] .* huber.(ŷ[1:2], y[1:2])) / length(wts)
```

Note the divisor `length(weights)` on the last line: The weighted measurement is not
literally the [weighted mean](https://en.wikipedia.org/wiki/Arithmetic_mean) but the
weighted mean scaled by the average value of the weights. To get the bone fide weighted
mean, use `multimeasure(..., mode=IMean())` instead. Another option is `Sum()`; see
[`StatisticalMeasuresBase.AggregationMode`](@ref) for other options.


#### Multi-target Huber loss

Here's the Huber loss for multi-targets (matrices or tables) which includes strict
argument checks, and works for higher dimensional arrays as well (argument checks can be
removed with [`unfussy(measure)`](@ref)):

```@example 42
MultitargetHuberLoss(args...; kwargs...) =
    multimeasure(HuberLoss(args...; kwargs...), transform = vec∘collect) |> fussy_measure
```

#### Demonstration

Multi-targets (as matrices):

```@example 42
y       = rand(3, 20)
ŷ       = rand(3, 20)
weights = rand(20)
ms = weights .* vec(mean(huber.(ŷ, y), dims=1))
@assert measurements(MultitargetHuberLoss(), ŷ, y, weights) ≈ ms
@assert MultitargetHuberLoss()(ŷ, y, weights) ≈  sum(ms)/length(weights)
```

Note the use of the `measurements` method, to return one measurement per observation,
instead of an aggregate.

Mutli-targets (as tables):

```@example 42
using Tables
t    = y' |> Tables.table |> Tables.rowtable
t̂    = ŷ' |> Tables.table |> Tables.rowtable
@assert MultitargetHuberLoss()(t̂, t, weights) ≈ MultitargetHuberLoss()(ŷ, y, weights)
```

Multi-dimensional arrays:

```@example 42
y    = rand(2, 3, 20)
ŷ    = rand(2, 3, 20)
weights = rand(20)
ms = weights .* vec(mean(huber.(ŷ, y), dims=[1, 2]))
@assert measurements(MultitargetHuberLoss(), ŷ, y, weights) ≈ ms
@assert MultitargetHuberLoss()(ŷ, y, weights) ≈  sum(ms)/length(weights)
```

Invalid arguments:

```julia
class_weights = Dict()
MultitargetHuberLoss()(ŷ, y, class_weights)
ERROR: ArgumentError: Class pool or value set is not compatible with the class_weight dictionary keys.
```

## Overloading traits

Here's how to overload [measure traits](@ref traits) to make additional promises of
behavior.

```@example 42
using ScientificTypesBase
@trait HuberLossOnScalars orientation=Loss()

typeof(HuberLoss())
```

```@example 42
const HuberLossType = API.Multimeasure{
    <:API.SupportsMissingsMeasure{
    <:HuberLossOnScalars
}}
@trait(
    HuberLossType,
    observation_scitype = Union{Continuous,Missing},
    human_name = "Huber loss",
)

API.observation_scitype(HuberLoss())
```

```@example 42
const MultitargetHuberLossType = API.FussyMeasure{<:API.Multimeasure{<:HuberLossType}}
@trait(
    MultitargetHuberLossType,
    observation_scitype = AbstractArray{<:Union{Continuous,Missing}},
    can_consume_tables = true,
    human_name = "multi-target Huber loss",
)
```

!!! note

    While most wrappers forward atomic measure traits appropriately,
    [`StatisticalMeasuresBase.observation_scitype(measure)`](@ref)
    (default=`Union{}`) and [`StatisticalMeasuresBase.can_consume_tables(measure)`](@ref)
    (default=`false`) must be explicitly
    overloaded for measures wrapped using `multimeasure`.

## Improving display of measures

Because most useful measures are wraps of atomic measures, they don't display well:

```@example 42
HuberLoss()
```

This can be improved using the [`@fix_show`](@ref) macro:

```@example 42
@fix_show HuberLoss::HuberLossType
HuberLoss()
```

## Macro shortcut (experimental)

The entire workflow above is equivalent to the code block below, except that `HuberLoss`
is also fussy and `MultitargetHuberLoss` gets an additional keyword argument
`atomic_weights`, for specifying weights per component of the vector-valued target (per
column if `y` is a table). The loss functions also accept `nothing` for weights or class
weights.

You will need to try this in a new Julia session or change the loss name. See
[`@combination`](@ref) for details.

```@example 43
valley(a, delta=1) = abs(a) <= delta ? a^2/2 : delta*(abs(a) - delta/2)
huber(ŷ, y, delta=1) = valley(ŷ - y, delta)

using StatisticalMeasuresBase
import StatisticalMeasuresBase as API
using ScientificTypesBase

@combination(
    HuberLoss(; delta=1) = multimeasure(huber),
    orientation =  Loss(),
    observation_scitype = Continuous,
    human_name = "Huber loss",
)
```

#### Demonstration

```@example 43
n = 10
y = vcat(fill(1, n)', fill(1, n)', fill(1, n)')
ŷ = vcat(fill(1, n)', fill(2, n)', fill(3, n)')
ŷ - y
```

```@example 43
delta = 10
valley(1, delta)
```

```@example 43
valley(2, delta)
```

```@example 43
measure = MultitargetHuberLoss(delta=10, atomic_weights=[5, 4, 1])
@assert measure(ŷ, y, fill(100, n)) ≈ (5*0 + 4*0.5 + 1*2.0)/3*100
```

```@example 43
API.observation_scitype(measure)
```
