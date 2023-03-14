# ## @trait

function name_value_pair(ex)
    ex.head in [:(=), :kw] || throw(ERR_NOT_NAME_VALUE_EXPRESSION(ex.head))
    return (ex.args[1], ex.args[2])
end

function trait_program(algorithm_ex, exs...)
    exs = (exs..., Meta.parse("is_measure = true"))
    program = quote end
    for ex in exs
        trait_ex, value_ex = name_value_pair(ex)
        trait_ex in OVERLOADABLE_TRAITS || throw(ERR_BAD_TRAIT(trait_ex))
        push!(
            program.args,
            :($StatisticalMeasuresBase.$trait_ex(::$algorithm_ex) = $value_ex),
        )
    end
    program
end

"""
    @trait SomeMeasureType trait1=value1 trait2=value2 ...

Declare `SomeMeasureType` a type whose instances are measures, and overload the specified
traits to have the given values on all such instances.

For example, if `AUC` is a type, then

    @trait AUC orientation = Loss() supports_weights = true

is equivalent to the declarations

    StatisticalMeasuresBase.is_measure(::AUC) = true
    StatisticalMeasuresBase.orientation(::AUC) = Score()
    StatisticalMeasuresBase.supports_weights(::AUC) = true

"""
macro trait(algorithm_ex, exs...)
    return esc(trait_program(algorithm_ex, exs...))
end


# ## skipinvalid

_isnan(x) = false
_isnan(x::Number) = isnan(x)

skipnan(x) = Iterators.filter(!_isnan, x)

# TODO: I don't think we're using the second method in this repo.

"""
    skipinvalid(itr; skipnan=true)

Return an iterator over the elements in `itr`, skipping `missing` and
`NaN` values. Behavior is similar to `skipmissing`.

If `skipnan=false`, then `skipinvalid` is equivalent to `skipmissing`.

---

    skipinvalid(A, B; skipnan=true)

For vectors `A` and `B` of the same length, return a tuple of vectors `(A[mask], B[mask])`
where `mask[i]` is `true` if and only if `A[i]` and `B[i]` are both valid (neither
`missing` nor `NaN`). Can also be called on other iterators of matching length, such as
arrays, but always returns a vector. Does not remove `Missing` from the element types if
present in the original iterators.

If `skipnan=false`, then `NaN`s are ignored.

"""
function skipinvalid(v; skipnan=true)
    ret = skipmissing(v)
    skipnan && return StatisticalMeasuresBase.skipnan(ret)
    return ret
end
function skipinvalid(yhat, y; skipnan=true)
    isbad = skipnan ? x -> ismissing(x) || _isnan(x) : ismissing
    mask = .!(isbad.(yhat) .| isbad.(y))
    return [yhat...][mask], [y...][mask]
end

# function _skipinvalid(yhat, y, w::Arr)
#     mask = .!(isinvalid.(yhat) .| isinvalid.(y))
#     return yhat[mask], y[mask], w[mask]
# end

# function _skipinvalid(yhat, y, w::Union{Nothing,AbstractDict})
#     mask = .!(isinvalid.(yhat) .| isinvalid.(y))
#     return yhat[mask], y[mask], w
# end


# ## check_numobs

"""
        check_numobs(X, Y)

Check if two objects `X` and `Y` supporting the MLJUtils.jl `numobs` interface have the
same number of observations. If they don't, throw an exception.

"""
@inline function check_numobs(X, Y)
    n = MLUtils.numobs(X)
    m = MLUtils.numobs(Y)
    n == m || throw(ERR_DIMENSIONS(n, m))
    return nothing
end


# ## check_pools

"""
    check_pools(A, B)

If `A` and `B` are both `CategoricalArray`s (or views thereof) check they have the same
class pool. If both `A` and `B` are ordered, check the pools have the same ordering.

If `B` an abstract dictionary, check the key set of `B` agrees with the class pool of `A`,
in the case `A` is a `CategoricalArray`. Otherwise, check it agrees with
`unique(skipmissing(A))`.

Otherwise perform no checks.

If a check fails throw an exception.

"""
check_pools(A, B) = nothing
function check_pools(
    A::CategoricalArrays.CatArrOrSub,
    B::CategoricalArrays.CatArrOrSub)
    levels_a = CategoricalArrays.levels(A)
    levels_b = CategoricalArrays.levels(B)
    if CategoricalArrays.isordered(A) && CategoricalArrays.isordered(B)
        levels_a == levels_b || throw(ERR_POOL_ORDER)
    else
        Set(levels_a) == Set(levels_b) || throw(ERR_POOL)
    end
    return nothing
end
function check_pools(A::CategoricalArrays.CatArrOrSub, dic::AbstractDict)
    issubset(CategoricalArrays.levels(A), collect(keys(dic))) ||
        throw(ERR_KEYSET)
    return nothing
end
function check_pools(A, dic::AbstractDict)
    issubset(unique(skipmissing(A)), collect(keys(dic))) || throw(ERR_KEYSET)
    return nothing
end


# ## check_weight_support

"""
    check_weight_support(measure, weight_args...)

Check if `measure` supports calls of the form `measure(ŷ, y, weight_args...)`. Will always
accept `nothing` as one or both weight arguments. A failed check throws an exception.

"""
check_weight_support(measure) = nothing
check_weight_support(::Nothing) = nothing
check_weight_support(measure, ::Nothing) = nothing
check_weight_support(measure, ::AbstractDict) =
    supports_class_weights(measure) ? nothing : throw(ERR_CLASS_WEIGHTS(measure))
check_weight_support(measure, weights) =
    supports_weights(measure) ? nothing : throw(ERR_WEIGHTS(measure))
check_weight_support(measure, ::Nothing, ::Nothing) = nothing
check_weight_support(measure, ::Nothing, ::AbstractDict) = nothing
check_weight_support(measure, ::Nothing, class_weights) = throw(ERR_BAD_CLASS_WEIGHTS)
check_weight_support(measure, weights, ::Nothing) =
    supports_weights(measure) ? nothing : throw(ERR_WEIGHTS(measure))
function check_weight_support(measure, weights, ::AbstractDict)
    supports_weights(measure)  ? nothing : throw(ERR_WEIGHTS(measure))
    supports_class_weights(measure)  ? nothing : throw(ERR_CLASS_WEIGHTS(measure))
end
check_weight_support(measure, weights, class_weights) = throw(ERR_BAD_CLASS_WEIGHTS)
check_weight_support(measure, weights, class_weights, arg, args...) =
    error("Measure provided too many arguments. ")


# ## unwrap

"""
    $API.unwrap(measure)

Remove one layer of wrapping from `measure`. If not wrapped, return `measure`.

See also [`$API.unfussy`](@ref).

"""
unwrap(measure) = measure
unwrap(measure::Wrapper) = getfield(measure, :atom)


# ## @combination

ERR_COMBINATION(a) = ArgumentError("@combination syntax error: $a. ")
ERR_COMBINATION(a, b) =
    ArgumentError("@combination syntax error: Expected $a, got $b. ")

const SCALAR_TRAITS = [:orientation, :external_aggregation_mode]


function _combination(assignment_ex)
    @capture(assignment_ex, constructor_ex_ = multimeasure_ex_) ||
         throw(ERR_COMBINATION("=", assignment_ex.head))
    if @capture(constructor_ex, Measure_())
        p = nothing
        p0 = nothing
    else
        @capture(constructor_ex, Measure_(; p_=p0_)) ||
            throw(ERR_COMBINATION(
                "Expected something like \"(; p=p0)\" but didn't get it. "
            ))
    end
    if @capture(multimeasure_ex, multimeasure(f_))
        mode = :(Mean())
    else
        @capture(multimeasure_ex, multimeasure(f_, mode=mode_)) ||
            throw(ERR_COMBINATION(
                "Expected something like \"multimeasure(f)\" "*
                    "or \"multimeasure(f, mode=...)\", but didn't get it. "*
                    "Note that only `multimeasure` is supported. "
            ))
    end
    return Measure, p, p0, f, mode
end

"""
    @combination SomeMeasure() = multimeasure(f)
    @combination SomeMeasure() = multimeasure(f, mode=...)

Advanced tool for generating multiple measure constructors from a single scalar function,
`(ŷ, y) -> f(ŷ, y)`. See "Enhancements" below for a variation for parameterized
functions.

Assuming `f(yhat, y)` is an ordinary function with scalar arguments, the above calls acts
as more-or-less as if `@combination` were absent, but with the following differences and
additional actions:

*1.* A new concrete measure type `SomeMeasureOnScalars` is added: If `sm =
SomeMeasureOnScalars()`, then `sm(yhat, y) = f(yhat, y)`.

*2.* Specifically, we have

    SomeMeasure() = multimeasure(
        supports_missings_measure(sm),
        mode=mode,
    ) |> robust_measure |> fussy_measure

so that `missing` scalar elements are supported, relevant argument checks are performed,
and weight arguments can be `nothing`.

*3.* An additional multi-target constructor is defined:

    MultitargetSomeMeasure(; atomic_weights=nothing) = multimeasure(
        multimeasure(supports_missings_measure(sm), mode=mode),
        atomic_weights=atomic_weights,
        transform=vec∘collect,
    ) |> robust_measure |> fussy_measure

This measure will have similar support for `missing` scalar elements and `nothing`
weights, and will perform argument checks. It can consume some kinds of tables.

*4.* The show method for displaying both kinds of measure is made friendlier; see
  [`@fix_show`](@ref).

Note that, by construction, `measure = SomeMeasure()` if and only if `measure isa
W{<:W<:W{<:W{<:SomeMeasureOnScalars}}}`, where `W = $API.Wrapper`, and `measure =
MultitargetSomeMeasure(; atomic_weights=wts)` for some `wts` if and only if `measure isa
W{<:W{<:W{<:W{<:W{<:SomeMeasureOnScalars}}}}}`.

# Enhancements

A single parameter can added to the provided expression, corresponding to the third
argument of `f`. Traits may be also be declared, as they apply to `SomeMeasure`, which are
appropriately lifted to `MultitargetSomeMeasure`, and dropped to `SomeScalarMeasure`.

Enhanced syntax example:


    f(yhat, y, tol) = abs(yhat - y)/max(abs(y), tol)
    @combination(
        ProportionalAbsoluteDifference(; tol=eps()) = multimeasure(f),
        observation_scitype = Continuous,     # becomes Union{Missing,Continuous}
        orientation=Loss(),
    )

For further elucidation, see the documentation Tutorial.

!!! note

    This marcro is experimental and its behavior is subject to change in patch and minor
    releases.

"""
macro combination(assignment_ex, trait_exs...)
    # using the enhanced syntax example in the docstring:
    #
    # p = :p
    # p0 = 2
    # f = :f
    # mode = :(Mean())
    #
    Measure, p, p0, f, mode = _combination(assignment_ex)
    MeasureOnScalars = Symbol("$(Measure)OnScalars") # :(SomeMeasureOnScalars)
    _Measure = Symbol("_$Measure")                   # :(_SomeMeasure)
    MeasureType = Symbol("$(Measure)Type")           # :(SomeMeasureType)
    _MeasureType = Symbol("_$(Measure)Type")         # :(_SomeMeasureType)
    MultitargetMeasure = Symbol("Multitarget$(Measure)")
    MultitargetMeasureType = Symbol("Multitarget$(Measure)Type")

    # # traits for unwrapped measure type `MeasureOnScalars`:

    scalar_trait_exs = filter(trait_exs) do ex
        ex.args[1] in SCALAR_TRAITS
    end

    # # traits for `Measure`:

    # without this omitting `human_name` trait leads to "on scalars" in fallback value:
    traits = map(ex -> ex.args[1], trait_exs)
    if !(:human_name in traits)
        name = snakecase(string(Measure), delim=' ')
        new_ex = Meta.parse("human_name = \"$name\"")
        trait_exs= (trait_exs..., new_ex)
    end

    # without this we don't get `Missing` in the measure observation_scitypes:
    for ex in trait_exs
        if ex.args[1] === :observation_scitype
            T_ex = ex.args[2]
            ex.args[2] = :(Union{Missing,$T_ex})
        end
    end

    # get rid of entries already accounted for in scalar type:
    trait_exs = filter(trait_exs) do ex
        !(ex.args[1] in SCALAR_TRAITS)
    end


    # ## Single target constructor

    program = if !isnothing(p)
        quote
            struct $MeasureOnScalars{T}
                $p::T
            end
            (measure::$MeasureOnScalars)(yhat, y) = $f(yhat, y, measure.$p)

            # constructor of measure (on vectors) without argument checks:
            $_Measure(p) = $StatisticalMeasuresBase.multimeasure(
                $StatisticalMeasuresBase.supports_missings_measure($MeasureOnScalars(p)),
                mode=$mode,
            )

            # constructor of actual measure:
            global $Measure(p) =  $_Measure(p) |>
                $StatisticalMeasuresBase.robust_measure |>
                $StatisticalMeasuresBase.fussy_measure
            global $Measure(; $p=$p0) = $Measure($p)

        end
    else
        quote
            struct $MeasureOnScalars end
            (::$MeasureOnScalars)(yhat, y) = $f(yhat, y)

            # constructor of measure (on vectors) without argument checks:
            $_Measure() =  $StatisticalMeasuresBase.multimeasure(
                $StatisticalMeasuresBase.supports_missings_measure($MeasureOnScalars()),
                mode=$mode,
            )

            # constructor of actual measure:
            global $Measure() =  $_Measure() |>
                $StatisticalMeasuresBase.robust_measure |>
                $StatisticalMeasuresBase.fussy_measure
        end
    end

    program2 = quote
        # a supertype for the measures without argument checks:
        $_MeasureType =
            $StatisticalMeasuresBase.Multimeasure{
                <:$StatisticalMeasuresBase.SupportsMissingsMeasure{<:$MeasureOnScalars}
            }

        # a supertype for the actual measures:
        $MeasureType = $StatisticalMeasuresBase.FussyMeasure{
            <:$StatisticalMeasuresBase.RobustMeasure{<:$_MeasureType}
        }

        # traits for `$MeasureOnScalars`:
        $StatisticalMeasuresBase.@trait($MeasureOnScalars, $(scalar_trait_exs...))

        # note traits for `$MeasureType` are inherited from `$_MeasureType`:
        $StatisticalMeasuresBase.@trait($_MeasureType, $(trait_exs...))

        # get nice show methods for measures constructed with `$Measure`:
        $StatisticalMeasuresBase.@fix_show $Measure::$MeasureType
    end


    # ## Multi-target constructor

    program3 = if !isnothing(p)
        quote
            global $MultitargetMeasure(p, atomic_weights=nothing) =
                $StatisticalMeasuresBase.multimeasure(
                    $_Measure(p);
                    atomic_weights=atomic_weights,
                    transform=vec∘collect,
                ) |> $StatisticalMeasuresBase.robust_measure |>
                    $StatisticalMeasuresBase.fussy_measure
            global $MultitargetMeasure(; $p=$p0, atomic_weights=nothing) =
                $MultitargetMeasure($p, atomic_weights)
        end
    else
        quote
            global $MultitargetMeasure(atomic_weights) =
                $StatisticalMeasuresBase.multimeasure(
                    $_Measure();
                    atomic_weights=atomic_weights,
                    transform=vec∘collect,
                ) |> $StatisticalMeasuresBase.robust_measure |>
                    $StatisticalMeasuresBase.fussy_measure
            global $MultitargetMeasure(; atomic_weights=nothing) =
                $MultitargetMeasure(atomic_weights)
        end
    end

    program4 = quote
        # supertype for the multitarget measures:
        $MultitargetMeasureType = $StatisticalMeasuresBase.FussyMeasure{
            <:$StatisticalMeasuresBase.RobustMeasure{
                <:$StatisticalMeasuresBase.Multimeasure{<:$_MeasureType}
            }
        }

        # add traits by hand:
        global $StatisticalMeasuresBase.can_consume_tables(::$MultitargetMeasureType) =
            true
        global $StatisticalMeasuresBase.observation_scitype(::$MultitargetMeasureType) =
            AbstractArray{<:$StatisticalMeasuresBase.observation_scitype($Measure())}
        global $StatisticalMeasuresBase.human_name(::$MultitargetMeasureType) =
            "multitarget "*$StatisticalMeasuresBase.human_name($Measure())

        $StatisticalMeasuresBase.@fix_show $MultitargetMeasure::$MultitargetMeasureType
    end

    append!(program.args, vcat(program2.args, program3.args, program4.args))

    quote
        let
        $(esc(program))
        end
    end
end
