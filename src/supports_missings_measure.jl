# # WRAPPING A MEASURE TO HANDLE MISSING OBSERVATIONS

struct SupportsMissingsMeasure{M} <: Wrapper{M}
    atom::M
end

# because properties are forwarded from atom (see wrappers.jl)
atom(measure::SupportsMissingsMeasure) = getfield(measure, :atom)

"""
    supports_missings_measure(atomic_measure)

Return a new measure, `measure`, with the same behavior as `atomic_measure`, but
supporting `missing` as a value for `ŷ` or `y` in calls like `measure(ŷ, y, args...)`, or
in applications of [`measurements`](@ref).  Missing values are propagated by the wrapped
measure (but may be skipped in subsequent wrapping or aggregation).

"""
supports_missings_measure(atom) = SupportsMissingsMeasure(atom)

call(measure::SupportsMissingsMeasure, yhat, y, args...) =
    atom(measure)(yhat, y, args...)
call(measure::SupportsMissingsMeasure, ::Missing, ::Missing, args...) = missing
call(measure::SupportsMissingsMeasure, ::Missing, y, args...) = missing
call(measure::SupportsMissingsMeasure, yhat, ::Missing, args...) = missing

measurments(measure::SupportsMissingsMeasure, yhat, y, args...) =
    measurments(atom(measure), yhat, y, args...)
measurments(measure::SupportsMissingsMeasure, ::Missing, ::Missing, args...) =
    missing
measurments(measure::SupportsMissingsMeasure, ::Missing, y, args...) =
    missing
measurments(measure::SupportsMissingsMeasure, yhat, ::Missing, args...) =
    missing


# # TRAITS

for trait in setdiff(OVERLOADABLE_TRAITS, [:observation_scitype,])
    quote
        $trait(measure::SupportsMissingsMeasure) = $trait(atom(measure))
    end |> eval
end
observation_scitype(measure::SupportsMissingsMeasure) =
    Union{Missing, observation_scitype(atom(measure))}
