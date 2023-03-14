struct FussyMeasure{M,F} <: Wrapper{M}
    atom::M
    extra_check::F
    function FussyMeasure(atom::M, extra_check::F) where {M,F}
        consumes_multiple_observations(atom) || throw(ERR_UNSUPPORTED_BY_FUSSY)
#       kind_of_proxy(atom) <: LearnAPI.IID || throw(ERR_UNSUPPORTED_BY_FUSSY2)
        new{M,F}(atom, extra_check)
    end
end

# because properties are forwarded from atom (see wrappers.jl)
atom(measure::FussyMeasure) = getfield(measure, :atom)
extra_check(measure::FussyMeasure) = getfield(measure, :extra_check)

# TODO: remove commented line above after LearnAPI becomes dependency?

"""
    fussy_measure(measure; extra_check=nothing)

Return a new measure, `fussy`, with the same behavior as `measure`, except that calling
`fussy` on data, or calling `measuremnts` on `fussy` and data, will will additionally:

- Check that if `weights` or `class_weights` are specified, then `measure` supports them
  (see [`$API.check_weight_support`](@ref))

- Check that `ŷ` (predicted proxy), `y` (ground truth), `weights` and `class_weights` are
  compatible, from the point of view of observation counts and class pools, if relevant
  (see and [`$API.check_numobs`](@ref) and [`$API.check_pools`](@ref)).

- Call `extra_check(measure, ŷ, y[, weights, class_weights])`, unless
  `extra_check==nothing`. Note the first argument here is `measure`, not `atomic_measure`.

Do not use `fussy_measure` unless both `y` and `ŷ` are expected to implement the
MLUtils.jl `getobs`/`numbos` interface (e.g., are `AbstractArray`s)

See also [`$API.measurements`](@ref), [`$API.is_measure`](@ref)

"""
fussy_measure(atom; extra_check=nothing) = FussyMeasure(atom, extra_check)

function _call(measure::FussyMeasure, yhat, y, weight_args...)
    check_numobs(yhat, y)
    check_pools(yhat, y)  # ignores case one is not categorical
    check_weight_support(measure, weight_args...)
    if !isempty(weight_args)
        w = weight_args[1]
        if w isa AbstractDict
            check_pools(y, w)
        elseif !isnothing(w)
            check_numobs(y, w)
            length(weight_args) > 1 &&
                !isnothing(weight_args[2]) && check_pools(y, weight_args[2])
        end
    end
    check = extra_check(measure)
    isnothing(check) || check(measure, yhat, y, weight_args...)
end

function call(measure::FussyMeasure, yhat, y, weight_args...)
    _call(measure, yhat, y, weight_args...)
    atom(measure)(yhat, y, weight_args...)
end

function measurements(measure::FussyMeasure, yhat, y, weight_args...)
    _call(measure, yhat, y, weight_args...)
    measurements(atom(measure), yhat, y, weight_args...)
end


# # TRAITS

for trait in OVERLOADABLE_TRAITS
    quote
        $trait(measure::FussyMeasure) = $trait(atom(measure))
    end |> eval
end


# # UNWRAPPING

"""
    unfussy(measure)

Return a version of `measure` with argument checks removed, if that is
possible. Specifically, if `measure == fussy_measure(atomic_measure)`, for some
`atomic_measure`, then return `atomic_measure`. Otherwise, return `measure`.

See also [`$API.fussy_measure`](@ref).

"""
unfussy(measure) = measure
unfussy(measure::FussyMeasure) = getfield(measure, :atom)
