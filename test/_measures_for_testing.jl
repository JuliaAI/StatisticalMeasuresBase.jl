# WARNING: Implementations here are for testing purposes only, and should not be used
# elsewhere.

# | measure                | can_report_unaggregated | supports weights | supports class weights |
# |------------------------|----------------|------------------|------------------------|
# | LPLoss()               | true           | true             | true                   |
# | MeanAbsoluteErrror()   | false          | true             | false                  |
# | RootMeanSquaredError() | false          | true             | false                  |
# | TruePositive()         | false          | false            | true                   |
# | TrueNegative()         | false          | true             | false                  |
# | FalsePositive()        | false          | true             | true                   |
# | FalseNegative()        | false          | false            | false                  |


# # lploss function

lploss(ηhat, η; p=2) = abs(ηhat - η).^p


# # LPLoss

struct LPLossOnScalars{T<:Real}
    p::T
end
LPLossOnScalars(; p=2) = LPLossOnScalars(p)

@trait(
    LPLossOnScalars,
    human_name = "Lᵖ-loss",
)

(measure::LPLossOnScalars)(yhat, y) = lploss(yhat, y; p=measure.p)

LPLossOnVectors(; p=2) = API.multimeasure(LPLossOnScalars(; p))
@trait(
    API.Multimeasure{<:LPLossOnScalars},
    observation_scitype = AbstractVector{<:Infinite,},
)

@fix_show LPLossOnVectors::API.Multimeasure{<:LPLossOnScalars}

# alias:
const l2 = LPLossOnVectors()

LPLoss(; p=2) =
    API.multimeasure(LPLossOnVectors(; p), mode=IMean(), transform=vec∘collect)
@trait(
    API.Multimeasure{<:API.Multimeasure{<:LPLossOnScalars}},
    observation_scitype = Infinite,
    can_consume_tables = true,
)

# # mae function

_mae(ŷ, y) = abs.(ŷ .- y) |> mean
_mae(ŷ, y, weights) = sum(abs.(ŷ .- y) .* weights)/sum(weights)


# # MeanAbsoluteError

struct MeanAbsoluteError end

@trait(
    MeanAbsoluteError,
    consumes_multiple_observations = true,
    observation_scitype = Infinite,
    supports_weights = true,
)

(::MeanAbsoluteError)(ŷ, y) = _mae(ŷ, y)
(::MeanAbsoluteError)(ŷ, y, w) = _mae(ŷ, y, w)


# # rms function

rms(ŷ, y) = (ŷ .- y).^2 |>  mean |> sqrt
rms(ŷ, y, weights) = sum((ŷ .- y).^2 .* weights) / sum(weights) |> sqrt


# # RootMeanSquaredError

struct RootMeanSquaredError end

@trait(
    RootMeanSquaredError,
    consumes_multiple_observations = true,
    observation_scitype = Infinite,
    supports_weights = true,
    external_aggregation_mode = RootMean(),
)

(::RootMeanSquaredError)(ŷ, y) = rms(ŷ, y)
(::RootMeanSquaredError)(ŷ, y, w) = rms(ŷ, y, w)


# # TruePositive

# supports class weights

struct TruePositive end

@trait(
    TruePositive,
    consumes_multiple_observations = true,
    observation_scitype = OrderedFactor,
    supports_class_weights =true,
    external_aggregation_mode = API.Sum(),
)

function (::TruePositive)(ŷ, y)
    positive_class = last(levels(y))
    (ŷ .== positive_class) .& (ŷ .== y)  |> sum
end

function (::TruePositive)(ŷ, y, class_weights::AbstractDict)
    positive_class = last(levels(y))
    weights = (class_weights[η] for η in MLUtils.eachobs(y))
    weights .* ((ŷ .== positive_class) .& (ŷ .== y))  |> sum
end


# # TrueNegative

# supports weights

struct TrueNegative end

@trait(
    TrueNegative,
    consumes_multiple_observations = true,
    observation_scitype = OrderedFactor,
    supports_weights =true,
    external_aggregation_mode = API.Sum(),
)

function(::TrueNegative)(ŷ, y)
    positive_class = last(levels(y))
    (ŷ .!= positive_class) .& (ŷ .== y)  |> sum
end

function(::TrueNegative)(ŷ, y, weights)
    positive_class = last(levels(y))
    weights .* ((ŷ .!= positive_class) .& (ŷ .== y))  |> sum
end


# # FalsePositive

# supports weights AND supports class_weights

struct FalsePositive end

@trait(
    FalsePositive,
    consumes_multiple_observations = true,
    observation_scitype = OrderedFactor,
    supports_weights =true,
    supports_class_weights=true,
    external_aggregation_mode = API.Sum(),
)

function (::FalsePositive)(ŷ, y)
    positive_class = last(levels(y))
    (ŷ .== positive_class) .& (ŷ .!= y)  |> sum
end

function (::FalsePositive)(ŷ, y, weights)
    positive_class = last(levels(y))
    weights .* ((ŷ .!= positive_class) .& (ŷ .!= y))  |> sum
end

function (::FalsePositive)(ŷ, y, class_weights::AbstractDict)
    weights = (class_weights[η] for η in MLUtils.eachobs(y))
    positive_class = last(levels(y))
    weights .* ((ŷ .!= positive_class) .& (ŷ .!= y))  |> sum
end

function (::FalsePositive)(ŷ, y, weights, class_weights)
    weights2 = (class_weights[η] for η in MLUtils.eachobs(y))
    positive_class = last(levels(y))
    weights2 .* (weights .* ((ŷ .!= positive_class) .& (ŷ .!= y)))  |> sum
end


# # FalseNegative

# does not support weights or class_weights

struct FalseNegative end

@trait(
    FalseNegative,
    consumes_multiple_observations = true,
    observation_scitype = OrderedFactor,
    external_aggregation_mode = API.Sum(),
)

function (::FalseNegative)(ŷ, y)
    positive_class = last(levels(y))
    (ŷ .!= positive_class) .& (ŷ .!= y)  |> sum
end


# # TraitTester

struct TraitTester{T}
    p::T
end

(::TraitTester)(yhat, y) = abs(yhat = y)

@trait(
    TraitTester,
    kind_of_proxy = Int, # bogus value for testing
    observation_scitype = ST.Unknown,
    orientation = Score(),
    external_aggregation_mode = Sum(),
)
