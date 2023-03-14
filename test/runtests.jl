import StatisticalMeasuresBase as API
using StatisticalMeasuresBase
using StatisticalMeasuresBase.CategoricalArrays
import StatisticalMeasuresBase.MLUtils
using StatisticalMeasuresBase.OrderedCollections
using Test
using ScientificTypes
import ScientificTypes as ST
using Statistics
import StableRNGs.StableRNG
using Tables


srng(n=123) = StableRNG(n)

include("_measures_for_testing.jl")

@testset "tools.jl" begin
    include("tools.jl")
end

@testset "arithmetic_dict.jl" begin
    include("arithmetic_dict.jl")
end

@testset "composite_weights.jl" begin
    include("composite_weights.jl")
end

@testset "aggregate.jl" begin
    include("aggregate.jl")
end

@testset "multimeasure.jl" begin
    include("multimeasure.jl")
end

@testset "tools_for_implementers.jl" begin
    include("tools_for_implementers.jl")
end

@testset "fussy_measure.jl" begin
    include("fussy_measure.jl")
end

@testset "supports_missings_measure.jl" begin
    include("supports_missings_measure.jl")
end

@testset "robust_measure.jl" begin
    include("robust_measure.jl")
end

@testset "measure.jl" begin
    include("measure.jl")
end

@testset "api.jl" begin
    include("api.jl")
end

@testset "integration.jl" begin
    include("integration.jl")
end

@testset "show.jl" begin
    include("show.jl")
end
