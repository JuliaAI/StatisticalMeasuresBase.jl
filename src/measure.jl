"""
    Measure(m)

Convert a measure-like object `m` to a measure in the sense of StatisticalMeasuresBase.jl;
see [`$API.is_measure`](@ref) for the definition.

Typically, `Measure` is applied to measures with pre-existing calling behaviour different
from that specified by StatisticalMeasuresBase.jl.

# New implementations

To make a measure-like object of type `M` wrappable by `Measure`, implement the
appropriate methods below. The first and last are compulsory.

```
(m::Measure{M})(ŷ, y)
(m::Measure{M})(ŷ, y, weights)
(m::Measure{M})(ŷ, y, class_weights::AbstractDict)
(m::Measure{M}, ŷ, y, weights, class_weights)
$API.measurements(m::Measure{M}, ŷ, y)
$API.measurements(m::Measure{M}, ŷ, y, weights)
$API.measurements(m::Measure{M}, ŷ, y, class_weights::AbstractDict)
$API.measurements(m::Measure{M}, ŷ, y, weights, class_weights)
$API.is_measure(m::Measure{M}) where M = true
```

In your implementations, you may use [`$API.unwrap`](@ref) to access the unwrapped object,
i.e., `$API.unwrap(Measure(m)) === m`.

# Sample implementation

To wrap the `abs` function as a measure that computes the absolute value of differences:

```
import StatisticalMeasuresBase as API

(measure::API.Measure{typeof(abs)})(yhat, y) = API.unwrap(measure)(yhat - y)
API.is_measure(::API.Measure{typeof(abs)}) = true

julia> API.Measure(abs)(2, 5)
3
```
"""
struct Measure{M} <: Wrapper{M}
    atom::M
    function Measure(m::M) where M
        is_measure(m) && return m
        candidate = new{M}(m)
        is_measure(candidate) || throw(ERR_NOT_CONVERTIBLE)
        return candidate
    end
end

# because properties are forwarded from atom (see wrappers.jl)
atom(measure::Measure) = getfield(measure, :atom)

for trait in OVERLOADABLE_TRAITS
    quote
        $trait(measure::Measure) = $trait(atom(measure))
    end |> eval
end


# # DISPLAY

Base.show(io::IO, measure::Measure) =
    print(io, "Measure("*repr(unwrap(measure))*")")
Base.show(io::IO, mime::MIME"text/plain", measure::Measure) =
    print(io, "Measure("*_repr_(unwrap(measure))*")")
