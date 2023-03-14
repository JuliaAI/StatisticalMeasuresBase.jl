using Documenter
using StatisticalMeasuresBase
const REPO="github.com/JuliaAI/StatisticalMeasuresBase.jl"

makedocs(;
    modules=[StatisticalMeasuresBase,],
    format=Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages=[
        "Overview" => "index.md",
        "Tutorial" => "tutorial.md",
        "Methods" => "methods.md",
        "Implementing New Measures" => "implementing_new_measures.md",
        "Tools for Implementers" => "tools_for_implementers.md",
    ],
    repo="https://$REPO/blob/{commit}{path}#L{line}",
    sitename="StatisticalMeasuresBase.jl"
)

deploydocs(
    ; repo=REPO,
    devbranch="dev",
    push_preview=false,
)
