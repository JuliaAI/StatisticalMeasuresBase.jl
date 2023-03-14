const VALUE_DISPLAY_LENGTH = 30
const INDENT = 2

const DOC_AGGREGATION_MODE =
    "Aggregation mode type. See [`$API.AggregationMode`](@ref)"

const ERR_ROOT_MEAN = ArgumentError(
    "The `p` in `RootMean(p)` must be greater than zero"
)

const DOC_MEAN =
    "Using `Mean()` in conjunction with weights returns "*
    "the usual weighted mean scaled by the average weight value. "

const DOC_WHATS_A_MEASURE =
    "See the StatisticalMeasuresBase.jl documentation for what consititutes a "*
    "\"measure\". "

const DOC_SCITYPES =
    "Scientific types can be imported from "*
    "ScientificTypesBase.jl; see also the ScientificTypes.jl documentation. "

ERR_BAD_FUNCTION(f) = ErrorException(
"It looks like you're trying to use the function $f as an aggregating "*
    "measure but have not flagged it as such. Consider declaring "*
    "`StatisticalMeasuresBase.can_report_unaggregated(::typeof($f)) = true`."
)

ERR_NOT_A_MEASURE(measure) = ArgumentError(
    "$measure is not a measure, as defined in by StatisticalMeasuresBase.jl. "*
        "Did you maybe pass a type instead of an instance? "
)

ERR_NOT_CONVERTIBLE = ArgumentError("Not convertibe to a $API.jl measure. ")

const ERR_UNSUPPORTED_BY_FUSSY = ArgumentError(
    "Only atomic measures consuming multiple observations can be wrapped using "*
        "`fussy_measure`. If you are the measures implementer, you may want to "*
        "check that `$API.consumes_multiple_observations(measure)` has correct` "*
        "value"
)

const ERR_UNSUPPORTED_BY_FUSSY2 = ArgumentError(
    "Only atomic measures for which `$API.kind_of_proxy(measure) <: LearnAPI.IID` can "*
        "be wrapped using `fussy_measure`. "
)

ERR_DIMENSIONS(n, m) = DimensionMismatch(
    "Encountered two objects with observation counts of $n and "*
        "$m which needed to match but don't. "
)
const ERR_POOL = ErrorException(
    "Conflicting categorical pools detected. "
)

const ERR_POOL_ORDER = ErrorException(
    "Conflicting categorical pools detected "*
        "or pools have a conflicting order. "
)

const ERR_KEYSET = ArgumentError(
    "Class pool or value set is not compatible "*
    "with the class weight dictionary keys. "
)

const RECOMMEND_ROBUST = "To ignore unsupported weights or class weights "*
    "when applying measures, first wrap your measure using `robust_measure`. "

ERR_WEIGHTS(measure) = ArgumentError(
    "$measure does not support weights. $RECOMMEND_ROBUST"
)

ERR_CLASS_WEIGHTS(measure) = ArgumentError(
    "$measure does not support class weights. $RECOMMEND_ROBUST"
)

const ERR_BAD_CLASS_WEIGHTS =
    ArgumentError("Class weights must be an abstract dictionary. ")

ERR_NOT_NAME_VALUE_EXPRESSION(head) = ArgumentError(
    "Expected `var=value` expression in @trait macro call but got `$head`-expression "*
    "instead. "
)

ERR_BAD_TRAIT(trait) = ArgumentError(
    "$trait is not an overloadable trait. Only these traits can be overloaded: "*
    "$OVERLOADABLE_TRAITS_LIST. "
)

ERR_MEASUREMENTS_UNSUPPORTED(measure) = ArgumentError(
    "The `measurements` cannot be called on $measure as "*
        "`$API.consumes_multiple_observations(measure)` is `false`. "
)
