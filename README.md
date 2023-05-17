# StatisticalMeasuresBase.jl

A Julia package for building production-ready measures (metrics) for statistics and machine learning

[![Build Status](https://github.com/JuliaAI/StatisticalMeasuresBase.jl/workflows/CI/badge.svg)](https://github.com/JuliaAI/StatisticalMeasuresBase.jl/actions)
[![Coverage](https://codecov.io/gh/JuliaAI/StatisticalMeasuresBase.jl/branch/master/graph/badge.svg)](https://codecov.io/github/JuliaAI/StatisticalMeasuresBase.jl?branch=master)
[![Docs](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliaai.github.io/StatisticalMeasuresBase.jl/dev/)

Related:
[StatisticalMeasures.jl](https://github.com/JuliaAI/StatisticalMeasuresBase.jl/actions).


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
L1 = multimeasure(supports_missings_measure(l1))
y = [1, 2, missing]
ŷ = [2, 3, 4]
weights = [8, 7, 6]

julia> L1(ŷ, y, weights)
5.0
```

```julia
multitarget_L1 = multimeasure(L1, transform=vec∘collect)
# 3 observations (last index is observation index):
y = [1 2 3; 2 4 6]
ŷ = [2 3 4; 4 6 8]

julia> multitarget_L1(ŷ, y, weights)
10.5
```

```julia
using Tables
t = y' |> Tables.table |> Tables.rowtable
t̂ = ŷ' |> Tables.table |> Tables.rowtable

julia> multitarget_L1(t̂, t, weights)
10.5
```

Access per-observation measurements with the measurement method:

```julia
julia> measurements(multitarget_L1, t̂, t, weights)

3-element Vector{Float64}:
 12.0
 10.5
  9.0
```

See [here](https://juliaai.github.io/StatisticalMeasuresBase.jl/dev/) for in-depth
documentation.
