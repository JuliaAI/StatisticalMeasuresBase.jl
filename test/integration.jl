# helper
huber(a; delta=1) = abs(a) <= delta ? a^2/2 : delta*(abs(a) - delta/2)

# ## Huber loss on scalars:

struct HuberLossOnScalars{T<:Real}
    delta::T
end
(measure::HuberLossOnScalars)(ŷ, y) = huber(ŷ - y)


# ### Demo

@test HuberLossOnScalars(1)( 7, 4) == huber(3)


# ## Huber loss on vectors, supporting missings

HuberLoss(delta) =
    multimeasure(HuberLossOnScalars(delta) |> supports_missings_measure, mode=IMean())
HuberLoss(; delta=1.0) = HuberLoss(delta)

# ### Demo

ŷ = [1, 2, missing]
y =    [7, 4, 6]
weights = [1, 3, 2]
class_weights = Dict(7=>3.0, 4=>4.0, 6=>2.0)

wts = weights .* (class_weights[η] for η in y)
@test HuberLoss(1)(ŷ, y, weights, class_weights) ≈
    sum(wts[1:2] .* huber.(ŷ[1:2] - y[1:2])) / sum(wts)


# ## Huber loss for arrays and  tables (with strict argument checks)

MultitargetHuberLoss(args...; kwargs...) =
    multimeasure(HuberLoss(args...; kwargs...), transform = vec∘collect) |> fussy_measure


# ## Demo

# multi-targets (as matrices):
y       = rand(3, 20)
ŷ       = rand(3, 20)
weights = rand(20)
ms = weights .* vec(mean(huber.(ŷ - y), dims=1))
@test measurements(MultitargetHuberLoss(), ŷ, y, weights) ≈ ms
@test MultitargetHuberLoss()(ŷ, y, weights) ≈  sum(ms)/sum(weights)

# mutli-targets (as tables):
using Tables
t    = y' |> Tables.table |> Tables.rowtable
t̂    = ŷ' |> Tables.table |> Tables.rowtable
@test MultitargetHuberLoss()(t̂, t, weights) ≈
    MultitargetHuberLoss()(ŷ, y, weights)

# argument checks:
class_weights = Dict()
@test_throws  API.ERR_KEYSET MultitargetHuberLoss()(ŷ, y, class_weights)
# ERROR: ArgumentError: Class pool or value set is not compatible with the
# class_weight dictionary keys.

# multidimensional arrays:
y       = rand(2, 3, 20)
ŷ    = rand(2, 3, 20)
weights = rand(20)
ms = weights .* vec(mean(huber.(ŷ - y), dims=[1, 2]))
@test measurements(MultitargetHuberLoss(), ŷ, y, weights) ≈ ms
@test MultitargetHuberLoss()(ŷ, y, weights) ≈  sum(ms)/sum(weights)


# TODO: check all wrappers overload measurements with tests
# TODO: check all wrappers forward traits with tests

# import LearnAPI

@trait HuberLossOnScalars orientation=Loss()

const HuberLossType = API.Multimeasure{
    <:API.SupportsMissingsMeasure{
    <:HuberLossOnScalars
}}
@trait(
    HuberLossType,
    observation_scitype = Union{ST.Continuous,Missing},
#   kind_of_proxy = LearnAPI.LiteralTarget(),
    human_name = "Huber loss",
)

const MultitargetHuberLossType = API.FussyMeasure{<:API.Multimeasure{<:HuberLossType}}
@trait(
    MultitargetHuberLossType,
    observation_scitype = AbstractArray{<:Union{Continuous,Missing}},
    can_consume_tables = true,
#   kind_of_proxy = LearnAPI.LiteralTarget(),
    human_name = "multi-target Huber loss",
)

m = MultitargetHuberLoss()
m isa MultitargetHuberLossType

@test API.is_measure(m)
@test API.consumes_multiple_observations(m)
@test API.can_report_unaggregated(m)
@test ST.scitype([1.0, 3.5, missing]) <: API.observation_scitype(m)
@test API.can_consume_tables(m)
@test API.supports_weights(m)
@test API.supports_class_weights(m)
@test API.orientation(m) == Loss()
@test API.external_aggregation_mode(m) == IMean()
@test API.human_name(m) == "multi-target Huber loss"
