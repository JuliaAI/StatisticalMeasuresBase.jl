# string consisting of carriage return followed by indentation of length n:
crind(n) = "\n"*repeat(' ', max(n, 0))

@inline function compact_repr(value)
    candidate = repr(value, context=:compact=>true)
    length(candidate) > VALUE_DISPLAY_LENGTH || return candidate
    "…"
end

function fancy(io::IO, object, name)
    anti = max(length(name) - INDENT)
    print(io, name, "(")
    names = propertynames(object)
    n_names = length(names)
    for k in eachindex(names)
        value =  getproperty(object, names[k])
        print(io, crind(length(name) - anti))
        print(io, "$(names[k]) = ")
        print(io, compact_repr(value))
        k == n_names || print(io, ", ")
    end
    print(io, ")")
    return nothing
end

function ordinary(io::IO, object, name)
    str = name # intitialization
    L = length(propertynames(object))
    if L > 0
        first_name = propertynames(object) |> first
        value = getproperty(object, first_name)
        str *= "($first_name = $(compact_repr(value))"
        L > 1 && (str *= ", …")
        str *= ")"
    else
        str *= "()"
    end
    print(io, str)
    return nothing
end

"""
    @fix_show constructor::T

Overload `Base.show` to get a human readable display of all objects of the form
`constructor(args...; kwargs...)`, given an upper bound `T` for the type of
such objects, that does not supertype any other objects.

# Example

Consider this definition of a constructor `LP`:

```julia
import StatisticalMeasuresBase as API
using StatisticalMeasuresBase

struct LPOnScalars{T}
    p::T
end
measure(yhat, y) = abs(yhat - y)^measure.p

LP(; p=2) = multimeasure(LPOnScalars(p))

julia> LP()
multimeasure(LPOnScalars{Int64}(2))
```

We fix this as follows:

```julia
LPType = API.Multimeasure{<:LPOnScalars}
@fix_show LP::LPType

julia> LP()
LP(
  p = 2)
```
"""
macro fix_show(ex)
    name = string(ex.args[1])
    T_ex = ex.args[2]
    quote
        Base.show(io::IO, ::MIME"text/plain", object::$T_ex) =
            $StatisticalMeasuresBase.fancy(io, object, $name)
        Base.show(io::IO, object::$T_ex) =
            $StatisticalMeasuresBase.ordinary(io, object, $name)
    end |> esc
end
