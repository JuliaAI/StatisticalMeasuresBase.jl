struct FooAgg end
API.can_report_unaggregated(::FooAgg) = true

struct FooNon end

@testset "observation_scitype" begin
    @test API.observation_scitype(LPLoss()) == Union{Infinite,Missing}
    @test API.observation_scitype(FooAgg()) == Union{}
end

@testset "supports_weights" begin
    @test !API.supports_weights(FooAgg())
    @test API.supports_weights(FooNon())
end

@testset "supports_class_weights" begin
    @test !API.supports_class_weights(FooAgg())
    @test API.supports_class_weights(FooNon())
end

@testset "human_name" begin
    @test API.human_name(FooAgg()) == "foo agg"
end

