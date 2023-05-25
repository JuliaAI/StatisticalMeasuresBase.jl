```@raw html
<script async defer src="https://buttons.github.io/buttons.js"></script>

<div style="font-size:1.4em;font-weight:bold;">
  <a href="tutorial"
    style="color: #389826;">Tutorial</a>           &nbsp;|&nbsp;
  <a href="https://juliaai.github.io/StatisticalMeasuresBase.jl/dev/implementing_new_measures/#definitions"
    style="color: #9558B2;">What is a measure?</a>
</div>

<span style="color: #9558B2;font-size:4.5em;">
StatisticalMeasuresBase.jl</span>
<br>
<span style="color: #9558B2;font-size:1.4em;font-style:italic;">
A Julia package for building production-ready measures (metrics) for statistics and machine learning</span>
<br><br>
```

### The main idea

Here's an example of a simple statistical measure, applied to a pair of scalars:

```@example 01
l1(ŷ, y) = abs(ŷ - y)
y = 5 # ground truth
ŷ = 2 # prediction
l1(ŷ, y)
```

Wrappers provided in this package extend the functionality of such measures. For example:

```@example 01
using StatisticalMeasuresBase
L1 = multimeasure(supports_missings_measure(l1), mode=Sum())
y = [5, 6, missing]
ŷ = [6, 8, 7]
weights = [1, 3, 9]
L1(ŷ, y, weights) ≈ 1*l1(6, 5) + 3*l1(8, 6)
```

```@example 01
multitarget_L1 = multimeasure(L1, transform=vec∘collect)
# 3 observations (last index is observation index):
y = [1 2 3; 2 4 6]
ŷ = [2 3 4; 4 6 8]
multitarget_L1(ŷ, y, weights)
```

```@example 01
using Tables
t = y' |> Tables.table |> Tables.rowtable
t̂ = ŷ' |> Tables.table |> Tables.rowtable
multitarget_L1(t̂, t, weights)
```

Generate measurements *for each observation* with the `measurement` method:

```@example 01
measurements(multitarget_L1, t̂, t, weights)
```

# Overview

This package specifies [an interface](@ref definitions) for statistical measures (metrics)
such as classical loss functions, confusion matrices, and proper scoring rules. It also
provides wrappers for extending their functionality. It does not implement actual
measures. For a package that does, based on this interface, see
[StatisticalMeasures.jl](https://github.com/JuliaAI/StatisticalMeasures.jl).  The wrappers
can also be applied to measures provided by other packages, such as
[LossFunctions.jl](https://github.com/JuliaML/LossFunctions.jl).

Specically, this package provides:

- A measure wrapper [`multimeasure`](@ref) that leverages MLUtils.jl to broadcast a simple
  measure over multiple observations; the main use case is for extending a measure (e.g.,
  function) that consumes single observations to measures consuming vectors, arrays or
  tables (multi-target measures).

- Other [wrappers](@ref wrappers) to add missing value support, argument checks, or to
  silently treat unsupported weights as uniform (good for application of a batch of
  measures with mixed degrees of weight support)

- [`measurements`](@ref), a method to return *unaggregated* measurements

- A number of optional [traits](@ref traits) to articulate contracts useful for client
  packages; for example, optimization packages may only work with measures that overload
  the `orientation` trait.

- [`aggregate`](@ref), a multipurpose measurement aggregation tool.

- [Technical tools](@ref tools) for implementing new measures, such as `CompositeWeights`,
  which combines per-observation weights and class weights into a single iterator.

### Contents

- [Tutorial](@ref)
- [Methods](@ref)
- [Implementing New Measures](@ref)
- [Tools for Implementers](@ref tools)
