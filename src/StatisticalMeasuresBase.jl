module StatisticalMeasuresBase

using Statistics
import InteractiveUtils.subtypes
import CategoricalArrays
import ScientificTypesBase
import MLUtils
using MacroTools
using OrderedCollections
using PrecompileTools

const API = "StatisticalMeasuresBase"

include("constants.jl")
include("tools.jl")
include("arithmetic_dict.jl")
include("types.jl")
include("traits.jl")
include("composite_weights.jl")
include("tools_for_implementers.jl")
include("aggregate.jl")
include("multimeasure.jl")
include("fussy_measure.jl")
include("supports_missings_measure.jl")
include("robust_measure.jl")
include("measure.jl")
include("wrappers.jl")
include("api.jl")
include("show.jl")
include("precompile.jl")

export @trait, @fix_show, @combination

# types
export Mean, Sum, RootMean, IMean, Score, Loss, Unoriented

# methods
export
    measurements,
    aggregate,
    multimeasure,
    fussy_measure,
    supports_missings_measure,
    robust_measure,
    unfussy,
    Measure
end
