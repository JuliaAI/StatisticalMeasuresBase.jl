struct RobustMeasure{M} <: Wrapper{M}
    atom::M
end

# because properties are forwarded from atom (see wrappers.jl)
atom(measure::RobustMeasure) = getfield(measure, :atom)

"""
    robust_measure(measure)

Return a new measure `robust` such that:

- `weights` and `class_weights` are silently treated as uniform (unit) if unsupported by
  `measure`

- if either `weights` or `class_weights` is `nothing`, it is as if the argument is
  omitted (interpreted as uniform)

This holds for all calls of the form `robust(ŷ, y, weights, class_weights)` or
`measurements(robust, ŷ, y, weights, class_weights)` and otherwise the behavior of
`robust` is the same as for `measure`.

"""
robust_measure(atom) = RobustMeasure(atom)

# defines calling and `measurements` in terms new functions `robust_call` and
# `robust_measurements`:
for op in [:call, :measurements]
    robust_op = Symbol("robust_$op")
    quote
        $op(measure::RobustMeasure, yhat, y) =
            $robust_op(atom(measure), yhat, y, nothing, nothing)

        $op(measure::RobustMeasure, yhat, y, weights) =
            $robust_op(atom(measure), yhat, y, weights, nothing)

        $op(measure::RobustMeasure, yhat, y, class_weights::AbstractDict) =
            $robust_op(atom(measure), yhat, y, nothing, class_weights)

        $op(measure::RobustMeasure, yhat, y, weights, class_weights) =
            $robust_op(atom(measure), yhat, y, weights, class_weights)

        $robust_op(measure, yhat, y, weights, class_weights) =
            $robust_op(
                measure,
                yhat,
                y,
                weights,
                class_weights,
                Val(supports_weights(measure)),
                Val(supports_class_weights(measure)),
            )
    end |> eval
end


# ## robust_call

# weights ×  class_weights ×
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{false},
    ::Val{false},
) = measure( yhat, y)

# weights ✓  class_weights ×
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{true},
    ::Val{false},
) = measure( yhat, y, weights)
robust_call(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights,
    ::Val{true},
    ::Val{false},
) = measure( yhat, y)

# weights ×  class_weights ✓
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{false},
    ::Val{true},
) = measure( yhat, y, class_weights)
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights::Nothing,
    ::Val{false},
    ::Val{true},
) = measure( yhat, y)

# weights ✓  class_weights ✓
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{true},
    ::Val{true},
) = measure( yhat, y, weights, class_weights)
robust_call(
    measure,
    yhat,
    y,
    weights,
    class_weights::Nothing,
    ::Val{true},
    ::Val{true},
) = measure( yhat, y, weights)
robust_call(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights,
    ::Val{true},
    ::Val{true},
) = measure( yhat, y, class_weights)
robust_call(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights::Nothing,
    ::Val{true},
    ::Val{true},
) = measure( yhat, y)


# ## robust_measurements

# weights ×  class_weights ×
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{false},
    ::Val{false},
) = measurements(measure, yhat, y)

# weights ✓  class_weights ×
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{true},
    ::Val{false},
) = measurements(measure, yhat, y, weights)
robust_measurements(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights,
    ::Val{true},
    ::Val{false},
) = measurements(measure, yhat, y)

# weights ×  class_weights ✓
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{false},
    ::Val{true},
) = measurements(measure, yhat, y, class_weights)
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights::Nothing,
    ::Val{false},
    ::Val{true},
) = measurements(measure, yhat, y)

# weights ✓  class_weights ✓
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights,
    ::Val{true},
    ::Val{true},
) = measurements(measure, yhat, y, weights, class_weights)
robust_measurements(
    measure,
    yhat,
    y,
    weights,
    class_weights::Nothing,
    ::Val{true},
    ::Val{true},
) = measurements(measure, yhat, y, weights)
robust_measurements(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights,
    ::Val{true},
    ::Val{true},
) = measurements(measure, yhat, y, class_weights)
robust_measurements(
    measure,
    yhat,
    y,
    weights::Nothing,
    class_weights::Nothing,
    ::Val{true},
    ::Val{true},
) = measurements(measure, yhat, y)


# # TRAITS

for trait in OVERLOADABLE_TRAITS
    quote
        $trait(measure::RobustMeasure) = $trait(atom(measure))
    end |> eval
end
