@testset "@trait" begin
    @test API.is_measure(LPLoss())
    @test API.human_name(LPLoss()) == "Lᵖ-loss"
    @test_throws(
        API.ERR_BAD_TRAIT(:junk),
        API.trait_program(Meta.parse.(("LPLoss", "junk=42"))...),
    )
end

@testset "skipinvalid" begin
    @test collect(API.skipinvalid([1, 2, missing, 3, NaN])) == [1 ,2, 3]
    want = [1, 2, 3, NaN]
    got = collect(API.skipinvalid([1, 2, missing, 3, NaN], skipnan=false))
    @test want[1:3] == got[1:3]
    @test isnan(got[4])
    @test API.skipinvalid([1, 2, missing, 3, NaN], [missing, 5, 6, 7, 8]) ==
        ([2, 3], [5, 7])
    want = ([2, 3, NaN], [5, 7, 8])
    got = API.skipinvalid([1, 2, missing, 3, NaN], [missing, 5, 6, 7, 8], skipnan=false)
    @test want[2] == got[2]
    @test want[1][1:2] == got[1][1:2]
    @test isnan(got[1][3])
end

@testset "check_numobs" begin
    @test isnothing(API.check_numobs(fill(42, 7, 5), fill(43, 8, 5)))
    x = fill(42, 7, 5)
    y = fill(42, 7, 6)
    @test_throws(
    API.ERR_DIMENSIONS(5, 6),
    API.check_numobs(x, y),
    )
end

@testset "check_pools" begin
    # ordered case:
    x = categorical(["yes", "no", "no", missing], ordered=true)
    levels!(x, ["yes", "no"])
    y = categorical([missing, "no", "yes", "yes"], ordered=true)
    levels!(y, ["yes", "no"])
    @test isnothing(API.check_pools(x, y))
    levels!(y, reverse(levels(y)))
    @test_throws API.ERR_POOL_ORDER API.check_pools(x, y)

    # one argument not ordered:
    x = categorical(["yes", "no", "no", missing], ordered=true)
    levels!(x, ["yes", "no"])
    y = categorical([missing, "no", "yes", "yes"])
    levels!(y, ["no", "yes"])
    @test isnothing(API.check_pools(x, y))
    y = categorical(["no", "yes", "yes", "maybe"])[1:end-1]
    @test_throws API.ERR_POOL API.check_pools(x, y)

    # dictionaries:
    dic = Dict("no" => 1, "yes" => 2, "maybe" => 3)
    @test isnothing(API.check_pools(x, dic))
    xplain =  ["yes", "no", "no", missing]
    @test isnothing(API.check_pools(xplain, dic))
    delete!(dic, "no")
    @test_throws API.ERR_KEYSET API.check_pools(x, dic)
    @test_throws API.ERR_KEYSET API.check_pools(xplain, dic)
end

@testset "check_weight_support" begin
    w = rand(3)
    class_w = Dict("yes"=>1)
    @test API.check_weight_support(FalsePositive(), w, class_w) |> isnothing
    @test API.check_weight_support(TruePositive(), class_w) |> isnothing
    @test API.check_weight_support(TrueNegative(), w) |> isnothing
    @test API.check_weight_support(FalseNegative()) |> isnothing
    @test_throws(
        API.ERR_WEIGHTS(TruePositive()),
        API.check_weight_support(TruePositive(), w, class_w),
    )
    @test_throws(
        API.ERR_CLASS_WEIGHTS(TrueNegative()),
        API.check_weight_support(TrueNegative(), w, class_w),
    )
    @test_throws(
        API.ERR_WEIGHTS(FalseNegative()),
        API.check_weight_support(FalseNegative(), w),
    )
    @test_throws(
        API.ERR_CLASS_WEIGHTS(FalseNegative()),
        API.check_weight_support(FalseNegative(), class_w),
    )
    @test_throws(
        API.ERR_BAD_CLASS_WEIGHTS,
        API.check_weight_support(FalsePositive(), w, "junk"),
    )
end

rng = srng(123)

huber(a, delta=1) = abs(a) <= delta ? a^2/2 : delta*(abs(a) - delta/2)
f(yhat, y, delta) = huber(yhat-y, delta)
f(yhat, y) = huber(yhat - y, 1)

@combination(
    HuberSum(; delta=1) = multimeasure(f, mode=Sum()),
    observation_scitype = Continuous,
    orientation=Loss(),
)

@testset "@combination with a parameter - basic measure" begin
    ŷ = [1, 2, missing]
    y =    [7, 4, 6]
    weights = [1, 3, 2]
    class_weights = Dict(7=>3.0, 4=>4.0, 6=>2.0)

    wts = weights .* (class_weights[η] for η in y)
    @test HuberSum(delta=1)(ŷ, y, weights, class_weights) ≈
        sum(wts[1:2] .* huber.(ŷ[1:2] - y[1:2]))

    # parameter `delta` is passing correctly:
    ŷ = rand(rng, 3)
    y = rand(rng, 3)
    weights = rand(rng, 3)
    huber5(a) = huber(a, 0.5)
    @test HuberSum(delta=0.5)(ŷ, y, weights) ≈
        sum(weights .* huber5.(ŷ - y))

    measure = HuberSum()
    @test API.is_measure(measure)
    @test API.consumes_multiple_observations(measure)
    @test API.can_report_unaggregated(measure)
    @test API.observation_scitype(measure) == Union{Missing,Continuous}
    @test !API.can_consume_tables(measure)
    @test API.supports_weights(measure)
    @test API.supports_class_weights(measure)
    @test API.orientation(measure) == Loss()
    @test API.external_aggregation_mode(measure) == Sum()
    @test API.human_name(measure) == "huber sum"
end

@testset "@combination with a parameter - multi-target measure" begin
    y       = rand(rng, 3, 20)
    ŷ       = rand(rng, 3, 20)
    weights = rand(rng, 20)
    ms = weights .* vec(sum(huber.(ŷ - y), dims=1))
    @test  measurements(MultitargetHuberSum(), ŷ, y, weights) ≈ ms
    @test MultitargetHuberSum()(ŷ, y, weights) ≈  sum(ms)

    feature_weights = rand(rng, 3)
    weighted = MultitargetHuberSum(; atomic_weights=feature_weights)
    ms = weights .* vec(sum(feature_weights .* huber.(ŷ - y), dims=1))
    @test  measurements(weighted, ŷ, y, weights) ≈ ms
    @test weighted(ŷ, y, weights) ≈  sum(ms)

    # mutli-targets (as tables):
    t    = y' |> Tables.table |> Tables.rowtable
    t̂    = ŷ' |> Tables.table |> Tables.rowtable
    @test weighted(t̂, t, weights) ≈ weighted(ŷ, y, weights)

    @test API.is_measure(weighted)
    @test API.consumes_multiple_observations(weighted)
    @test API.can_report_unaggregated(weighted)
    @test API.observation_scitype(weighted) == AbstractArray{<:Union{Missing,Continuous}}
    @test API.can_consume_tables(weighted)
    @test API.supports_weights(weighted)
    @test API.supports_class_weights(weighted)
    @test API.orientation(weighted) == Loss()
    @test API.external_aggregation_mode(weighted) == Sum()
    @test API.human_name(weighted) == "multitarget huber sum"

end

@combination(
    HuberSum1() = multimeasure(f, mode=Sum()),
    observation_scitype = Continuous,
    orientation=Loss(),
)

@testset "@combination without a parameter - basic measure" begin
    ŷ = [1, 2, missing]
    y =    [7, 4, 6]
    weights = [1, 3, 2]
    class_weights = Dict(7=>3.0, 4=>4.0, 6=>2.0)

    wts = weights .* (class_weights[η] for η in y)
    @test HuberSum1()(ŷ, y, weights, class_weights) ≈
        sum(wts[1:2] .* huber.(ŷ[1:2] - y[1:2]))

    measure = HuberSum1()
    @test API.is_measure(measure)
    @test API.consumes_multiple_observations(measure)
    @test API.can_report_unaggregated(measure)
    @test API.observation_scitype(measure) == Union{Missing,Continuous}
    @test !API.can_consume_tables(measure)
    @test API.supports_weights(measure)
    @test API.supports_class_weights(measure)
    @test API.orientation(measure) == Loss()
    @test API.external_aggregation_mode(measure) == Sum()
    @test API.human_name(measure) == "huber sum1"
end

@testset "@combination with a paramter - multi-target measure" begin
    y       = rand(rng, 3, 20)
    ŷ       = rand(rng, 3, 20)
    weights = rand(rng, 20)
    ms = weights .* vec(sum(huber.(ŷ - y), dims=1))
    @test  measurements(MultitargetHuberSum1(), ŷ, y, weights) ≈ ms
    @test MultitargetHuberSum1()(ŷ, y, weights) ≈  sum(ms)

    feature_weights = rand(rng, 3)
    weighted = MultitargetHuberSum1(; atomic_weights=feature_weights)
    ms = weights .* vec(sum(feature_weights .* huber.(ŷ - y), dims=1))
    @test  measurements(weighted, ŷ, y, weights) ≈ ms
    @test weighted(ŷ, y, weights) ≈  sum(ms)

    # mutli-targets (as tables):
    t    = y' |> Tables.table |> Tables.rowtable
    t̂    = ŷ' |> Tables.table |> Tables.rowtable
    @test weighted(t̂, t, weights) ≈ weighted(ŷ, y, weights)

    @test API.is_measure(weighted)
    @test API.consumes_multiple_observations(weighted)
    @test API.can_report_unaggregated(weighted)
    @test API.observation_scitype(weighted) == AbstractArray{<:Union{Missing,Continuous}}
    @test API.can_consume_tables(weighted)
    @test API.supports_weights(weighted)
    @test API.supports_class_weights(weighted)
    @test API.orientation(weighted) == Loss()
    @test API.external_aggregation_mode(weighted) == Sum()
    @test API.human_name(weighted) == "multitarget huber sum1"
end

true
