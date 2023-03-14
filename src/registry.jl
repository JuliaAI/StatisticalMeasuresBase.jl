"""
    $API.StatisticalMeasuresBase.measures()

*Experimental* and subject to breaking behavior between patch releases.

Return a dictionary, `dict`, keyed on "registered" measure constructors. The value of
`dict[constructor]` provides information about traits shared by all measures
constructed using the syntax `constructor(args...)`.

New constructors are registered using the [`$API.register`](@ref) command, which is
typically declared in some measure-providing package. The dictionary is a global constant
of the StatisticalMeasuresBase module.

"""
measures() = TRAITS_GIVEN_CONSTRUCTOR[]

"""
    $API.StatisticalMeasuresBase.register(constructor, aliases=String[])

**Experimental** and subject to breaking behavior between patch releases.

Add the specified measure `constructor` to the keys of the dictionary owned by the
StatisticalMeasuresBase module which is returned by `$API.measures()`. At registration,
the dictionary value assigned to the key `constructor` is a named tuple keyed on trait
names, with values the corresponding traits of the measure `constructor()`. Registration
implies a contract that these trait values are the same for all measures of the form
`constructor(args...)`. An additional key of the named tuple `:aliases`, which has the
specified `aliases` as value. The aliases must be `String`s. 

"""
function register(constructor, aliases...)
    @info "registering $constructor"
    measure = try
        constructor()
    catch ex
        @error ERR_BAD_CONSTRUCTOR
        throw(ex)
    end
    traits = NamedTuple{tuple(METADATA_TRAITS...)}(tuple(
        (trait(measure) for trait in  METADATA_TRAIT_FUNCTIONS)...
            ))
    extended_traits = (; aliases, traits...)
    TRAITS_GIVEN_CONSTRUCTOR[][constructor] = extended_traits
end
