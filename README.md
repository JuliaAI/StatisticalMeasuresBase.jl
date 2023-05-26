# StatisticalMeasuresBase.jl

A Julia package for building production-ready measures (metrics) for statistics and machine learning

[![Build Status](https://github.com/JuliaAI/StatisticalMeasuresBase.jl/workflows/CI/badge.svg)](https://github.com/JuliaAI/StatisticalMeasuresBase.jl/actions)
[![Coverage](https://codecov.io/gh/JuliaAI/StatisticalMeasuresBase.jl/branch/master/graph/badge.svg)](https://codecov.io/github/JuliaAI/StatisticalMeasuresBase.jl?branch=master)
[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaai.github.io/StatisticalMeasuresBase.jl/dev/)

Related:
[StatisticalMeasures.jl](https://juliaai.github.io/StatisticalMeasures.jl/dev/)

[List](https://github.com/FluxML/FluxML-Community-Call-Minutes/discussions/38) of Julia packages providing metrics.

## The main idea

Here's an example of a simple statistical measure that can be applied to a pair of scalars:

```julia
l1(ŷ, y) = abs(ŷ - y)
y = 5 # ground truth
ŷ = 2 # prediction

julia> l1(ŷ, y)
3
```

Wrappers provided in this package extend the functionality of such measures. For example:

```julia
using StatisticalMeasuresBase
L1 = multimeasure(supports_missings_measure(l1), mode=Sum())
y = [5, 6, missing]
ŷ = [6, 8, 7]
weights = [1, 3, 9]

julia> L1(ŷ, y, weights) ≈ 1*l1(6, 5) + 3*l1(8, 6)
true
```

```julia
multitarget_L1 = multimeasure(L1, transform=vec∘collect)
# 3 observations (last index is observation index):
y = [1 2 3; 2 4 6]
ŷ = [2 3 4; 4 6 8]

julia> multitarget_L1(ŷ, y, weights)
39
```

```julia
using Tables
t = y' |> Tables.table |> Tables.rowtable
t̂ = ŷ' |> Tables.table |> Tables.rowtable

julia> multitarget_L1(t̂, t, weights)
39
```

Generate measurements *for each observation* with the `measurement` method:

```julia
julia> measurements(multitarget_L1, t̂, t, weights)
3-element Vector{Int64}:
  3
  9
 27
```

See [here](https://juliaai.github.io/StatisticalMeasuresBase.jl/dev/) for in-depth
documentation.
