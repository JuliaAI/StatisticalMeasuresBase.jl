# # CompositeWeights

const ERR_WEIGHTS_EXHAUSTED = ArgumentError(
    "Weights exhausted while paired observations are still remaining. "
)

"""
    $API.CompositeWeights(y)
    $API.CompositeWeights(y, weights)
    $API.CompositeWeights(y, weights, class_weights)
    $API.CompositeWeights(y, class_weights::AbstractDict)

Return an iterator which combines, with ordinary multiplication, the specified `weights`
and `class_weights`, given a target `y`.

```julia
y = ["a", "b", "b", "b"]
weights = [1, 2, 3, 4]
class_weights = Dict("a"=>2, "b"=>1)
combined = $API.CompositeWeights(y, weights, class_weights)

julia> collect(combined)
4-element Vector{Any}:
 2
 2
 3
 4
```

Omitted or `nothing` `weights`/`class_weights` are interpreted as uniform. Unless
`nothing`, the length of `weights` is expected to be (at least) the number of observations
in `y` and the keys of `class_weights` should include all values of `y`.

Class weights transform `missing` values of `y` to zeros.

```julia
y = [missing, "a", "b", "b", "b"]
class_weights = Dict("a"=>2, "b"=>1)
combined = $API.CompositeWeights(y, class_weights)
collect(combined)
julia> collect(combined)
5-element Vector{Int64}:
 0
 2
 1
 1
 1
```

"""
struct CompositeWeights{n,W,K,V,O}
    observations::O # implements `getobs` and `numobs`
    weights::W
    class_weights::AbstractDict{K,V}
    function CompositeWeights(
        observations::O,
        weights::W,
        class_weights::AbstractDict{K,V},
        ) where {W,K,V,O}
        n = MLUtils.numobs(observations)
        return new{n,W,K,V,O}(observations, weights, class_weights)
    end
end

# local private alias for case of only class weights:
const ClassCompositeWeights{V} = CompositeWeights{
    n,
    Nothing,
    K,
    V,
    O,
} where {n,K,O}

Base.IteratorEltype(::Type{<:ClassCompositeWeights{V}}) where V =
    Base.HasEltype()
Base.eltype(::Type{<:ClassCompositeWeights{V}}) where V = V
Base.length(w::CompositeWeights) = MLUtils.numobs(w.observations)

CompositeWeights(observations) = nothing
CompositeWeights(observations, ::Nothing, ::Nothing) = nothing
CompositeWeights(observations, weights) = weights
CompositeWeights(observations, class_weights::AbstractDict) =
    CompositeWeights(observations, nothing, class_weights)

_get(d::AbstractDict, key) = d[key]
_get(d::AbstractDict{<:Any,T}, ::Missing) where T = zero(T)

# only class weights:
function Base.iterate(w::CompositeWeights{n,Nothing}) where n
    n == 0 && return nothing
    obs = MLUtils.getobs(w.observations, 1)
    item = _get(w.class_weights, obs)
    state = 1
    return item, state
end
function Base.iterate(w::CompositeWeights{n,Nothing}, state) where n
    state == n && return nothing
    state += 1
    obs = MLUtils.getobs(w.observations, state)
    item = _get(w.class_weights, obs)
    state
    item, state
end

# both observation weights and class weights:
function Base.iterate(w::CompositeWeights{n}) where n
    n == 0 && return nothing
    next_weight = iterate(w.weights)
    isnothing(next_weight) && throw(ERR_WEIGHTS_EXHAUSTED)
    weight, weight_state = next_weight
    obs = MLUtils.getobs(w.observations, 1)
    item = weight*_get(w.class_weights, obs)
    new_state = (1, weight_state)
    item, new_state
end
function Base.iterate(w::CompositeWeights{n}, state) where n
    i, weight_state = state
    i == n && return nothing
    i += 1
    next_weight = iterate(w.weights, weight_state)
    isnothing(next_weight) && throw(ERR_WEIGHTS_EXHAUSTED)
    weight, new_weight_state = next_weight
    obs = MLUtils.getobs(w.observations, i)
    item = weight*_get(w.class_weights, obs)
    new_state = (i, new_weight_state)
    item, new_state
end
