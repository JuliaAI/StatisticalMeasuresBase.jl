# Methods

| method                 | description                                                            |
|:-----------------------|:-----------------------------------------------------------------------|
| [`measurements`](@ref) | for returning individual per-observation measurements                  |
| [`aggregate`](@ref)    | multipurpose measurement aggregation                                   |

The [`aggregate`](@ref) method takes an optional aggregation `mode` argument, with default
`Mean()`, whose possible values are explained below.

```@docs
StatisticalMeasuresBase.AggregationMode
```

## [Wrappers](@id wrappers)

| method                                        | description                                                              |
|:----------------------------------------------|:-------------------------------------------------------------------------|
| [`supports_missings_measure(measure)`](@ref)  | wrapper to add missing value support                                     |
| [`multimeasure`](@ref)`(measure; options...)` | wrapper to broadcast measures over multiple observations                 |
| [`fussy_measure(measure)`](@ref)              | wrapper to add strict argument checks                                    |
| [`robust_measure(measure)`](@ref)             | wrapper to silently treat unsupported weights as uniform                 |
| [`Measure(m)`](@ref)                          | convert a measure-like object `m` to StatisticalMeasuresBase.jl meausure |


## Unwrapping

| method                                            | description                                               |
|:--------------------------------------------------|:----------------------------------------------------------|
| [`unfussy(measure)`](@ref)                        | remove [`fussy_measure`](@ref) wrap if this is outer wrap |
| [`StatisticalMeasuresBase.unwrap(measure)`](@ref) | remove one layer of wrapping                              |


## Traits

The following traits, provide further information about measures:

| method                                                                    | description                                                                       |
|:--------------------------------------------------------------------------|:----------------------------------------------------------------------------------|
| [`StatisticalMeasuresBase.is_measure(measure)`](@ref)                     | `true` if `measure` is known to be a StatisticalMeasuresBase.jl compliant measure |
| [`StatisticalMeasuresBase.consumes_multiple_observations(measure)`](@ref) | "observations" in the sense of MLUtils.jl                                         |
| [`StatisticalMeasuresBase.can_report_unaggregated(measure)`](@ref)        | `true` if `measurements` generally returns *different* values                     |
| [`StatisticalMeasuresBase.kind_of_proxy(measure)`](@ref)                  | kind of proxy for target predictions, `ŷ`, e.g. `LearnAPI.Distribution()`         |
| [`StatisticalMeasuresBase.observation_scitype(measure)`](@ref)            | upper bound on scitype of single ground truth observation; see ScientificTypes.jl |
| [`StatisticalMeasuresBase.can_consume_tables(measure)`](@ref)             | ground truth and prediction can be some kinds of table                            |
| [`StatisticalMeasuresBase.supports_weights(measure)`](@ref)               | `true` if per-observation weights are supported                                   |
| [`StatisticalMeasuresBase.supports_class_weights(measure)`](@ref)         | `true` if class weights are supported                                             |
| [`StatisticalMeasuresBase.orientation(measure)`](@ref)                    | `Loss()`, `Score()` or `Unoriented()`                                             |
| [`StatisticalMeasuresBase.external_aggregation_mode(measure)`](@ref)      | One of `Mean()`, `Sum()`, etc                                                     |
| [`StatisticalMeasuresBase.human_name(measure)`](@ref)                     | human-readable name of measure                                                    |


## Reference

```@docs
StatisticalMeasuresBase.measurements
StatisticalMeasuresBase.aggregate
```

### Wrappers

```@docs
StatisticalMeasuresBase.supports_missings_measure
StatisticalMeasuresBase.multimeasure
StatisticalMeasuresBase.fussy_measure
StatisticalMeasuresBase.robust_measure
StatisticalMeasuresBase.Measure
```

### Unwrapping

```@docs
StatisticalMeasuresBase.unfussy
StatisticalMeasuresBase.unwrap
```

### Traits

```@docs
StatisticalMeasuresBase.is_measure
StatisticalMeasuresBase.consumes_multiple_observations
StatisticalMeasuresBase.can_report_unaggregated
StatisticalMeasuresBase.kind_of_proxy
StatisticalMeasuresBase.observation_scitype
StatisticalMeasuresBase.can_consume_tables
StatisticalMeasuresBase.supports_weights
StatisticalMeasuresBase.supports_class_weights
StatisticalMeasuresBase.orientation
StatisticalMeasuresBase.external_aggregation_mode
StatisticalMeasuresBase.human_name
```
