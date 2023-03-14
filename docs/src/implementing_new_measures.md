# Implementing New Measures

Use this section as a guide to what should be implemented by new measure types.

## [What's a measure?](@id definitions)

In brief, a *measure* is a function, or other callable object, `m`, with the following
calling syntax:

```julia
m(ŷ, y)
m(ŷ, y, weights)
m(ŷ, y, class_weights::AbstractDict)
m(ŷ, y, weights, class_weights)
```

Only the first signature is obligatory. The argument `y` is some kind of "ground truth"
and `ŷ` a corresponding "prediction". The return value will be an aggregated
"measurement".  See [`StatisticalMeasuresBase.is_measure`](@ref) for details.

Of course `m` could be an instance of some type with parameters.

A wrapper [`Measure`](@ref) enables measure-like objects with different calling
behavior to be regarded as StatisticalMeasuresBase.jl measures.


## Principal methods

| method                                         | compulsory for new measures? | fallback                                              |
|:-----------------------------------------------|:-----------------------------|:------------------------------------------------------|
| direct callability (see above)                 | yes                          |                                                       |
| [`StatisticalMeasuresBase.measurements`](@ref) | no                           | repeats ``n`` times the output of calling the measure |


## [Traits](@id traits)

A measure *trait* is just a function with single argument, `measure`, used to promise
additional behavior.  A convenience macro [`@trait`](@ref) exists for overloading
traits. Overloading traits, apart from `is_measure`, is optional, but generally
recommended. See the table under [Methods](@ref) for a summary of the contracts implied
by traits.

Mostly a measure wrapper, such as `supports_missings_measure`, just propagates trait
values. See the last column of the table for special cases where you may want to consider
overloading traits for wrapped measures.

| method                                                                    | comment                                         | general fallback | overload for wrapper?     |
|:--------------------------------------------------------------------------|:------------------------------------------------|:-----------------|:--------------------------|
| [`StatisticalMeasuresBase.is_measure(measure)`](@ref)                     | overloading automatic if using [`@trait`](@ref) | `false`          | no                        |
| [`StatisticalMeasuresBase.consumes_multiple_observations(measure)`](@ref) |                                                 | `false`          | no                        |
| [`StatisticalMeasuresBase.can_report_unaggregated(measure)`](@ref)        |                                                 | `false`          | no                        |
| [`StatisticalMeasuresBase.kind_of_proxy`](@ref)`(measure)`                | strongly recommended                            | `nothing`        | maybe for `multimeasure`  |
| [`StatisticalMeasuresBase.observation_scitype`](@ref)`(measure)`          |                                                 | `Union{}`        | likely for `multimeasure` |
| [`StatisticalMeasuresBase.can_consume_tables`](@ref)`(measure)`           | strongly recommended if supported               | `false`          | maybe for `multimeasure`  |
| [`StatisticalMeasuresBase.supports_weights`](@ref)`(measure)`             | strongly recommended if supported               | `false`          | no                        |
| [`StatisticalMeasuresBase.supports_class_weights`](@ref)`(measure)`       | strongly recommended if supported               | `false`          | no                        |
| [`StatisticalMeasuresBase.orientation`](@ref)`(measure)`                  | strongly recommended                            | `Unoriented`     | no                        |
| [`StatisticalMeasuresBase.external_aggregation_mode`](@ref)`(measure)`    |                                                 | `Mean()`         | no                        |
| [`StatisticalMeasuresBase.human_name`](@ref)`(measure)`                   |                                                 | see docstring    | maybe                     |
