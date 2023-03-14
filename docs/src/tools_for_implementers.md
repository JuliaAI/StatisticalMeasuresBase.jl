# [Tools for Implementers](@id tools)

| method                                                   | purpose                                                                  |
|:---------------------------------------------------------|:-------------------------------------------------------------------------|
| [`@trait`](@ref)                                         | syntactic sugar for  declaring traits                                    |
| [`@fix_show`](@ref)                                      | improve display of a measure                                             |
| [`aggregate`](@ref)                                      | for explicit aggregation if [`multimeasure`](@ref) is not fit to purpose |
| [`StatisticalMeasuresBase.skipinvalid`](@ref)            | skip `NaN` and `missing` values                                          |
| [`StatisticalMeasuresBase.check_numobs`](@ref)`(y1, y2)` | check `y1` and `y2` have same number of observations                     |
| [`StatisticalMeasuresBase.check_pools`](@ref)`(y1, y2)`  | check `y1` and `y2` have the same class pools                            |
| [`StatisticalMeasuresBase.check_weight_support`](@ref)   | check if a measure supports specified weights                            |
| [`StatisticalMeasuresBase.CompositeWeights`](@ref)       | combine weights and class_weights into single iterator                   |
| [`StatisticalMeasuresBase.weighted`](@ref)               | broadcast weights over observations without aggregation                  |
| [`StatisticalMeasuresBase.Wrapper{M}`](@ref)             | the abstract type for measure wrappers                                   |
| [`@combination`](@ref)                                   | generate multiple measures from a single scalar function                 |


> Table of convenience methods available for new measure type implementations

## Reference

```@docs
@trait
@fix_show
StatisticalMeasuresBase.skipinvalid
StatisticalMeasuresBase.check_numobs
StatisticalMeasuresBase.check_pools
StatisticalMeasuresBase.check_weight_support
StatisticalMeasuresBase.CompositeWeights
StatisticalMeasuresBase.weighted
StatisticalMeasuresBase.Wrapper
@combination
```


