using Documenter
using StatisticalMeasuresBase

makedocs(
    modules=[StatisticalMeasuresBase,],
    format=Documenter.HTML(
        prettyurls=true,
        collapselevel=1,
    ),
    pages=[
        "Overview" => "index.md",
        "Tutorial" => "tutorial.md",
        "Methods" => "methods.md",
        "Implementing New Measures" => "implementing_new_measures.md",
        "Tools for Implementers" => "tools_for_implementers.md",
    ],
    warnonly = [:cross_references, :missing_docs],
    repo=Remotes.GitHub("JuliaAI", "StatisticalMeasuresBase.jl"),
    sitename="StatisticalMeasuresBase.jl"
)

deploydocs(
    repo="github.com/JuliaAI/StatisticalMeasuresBase.jl.git",
    devbranch="dev",
    push_preview=false,
)
