# `Wrapper` type is defined in src/types.jl

# # PROPERTY FORWARDING

Base.propertynames(measure::Wrapper) = propertynames(getfield(measure, :atom))
Base.getproperty(measure::Wrapper, name::Symbol) =
    getproperty(getfield(measure, :atom), name)


# # DISPLAY

Base.show(io::IO, measure::Wrapper) =
    show(io, unwrap(measure))
Base.show(io::IO, mime::MIME"text/plain", measure::Wrapper) =
    print(io, _repr_(unwrap(measure)))


# # CALLABILITY

# In wrapper code it is convenient to define calling behaviour first in terms a `call`
# method, instead of directly. Here is where we explicitly make the wrapped measures
# callable:

(measure::Wrapper)() = call(measure)
(measure::Wrapper)(args) = call(measure, args)
(measure::Wrapper)(arg, args...) = call(measure, arg, args...)

