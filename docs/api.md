  Activating project at `~/.julia/environments/work`
Current working directory: docs
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.8.5 (2023-01-08)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> )
ERROR: syntax: unexpected ")"
Stacktrace:
 [1] top-level scope
   @ none:1

(@work) pkg> activate --shared measure
  Activating project at `~/.julia/environments/measure`

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
[ Info: Precompiling StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc]
ERROR: LoadError: syntax: colon expected in "?" expression
Stacktrace:
 [1] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/src/traits.jl:260
 [2] include(mod::Module, _path::String)
   @ Base ./Base.jl:419
 [3] include(x::String)
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
 [4] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:10
 [5] include
   @ ./Base.jl:419 [inlined]
 [6] include_package_for_output(pkg::Base.PkgId, input::String, depot_path::Vector{String}, 
dl_load_path::Vector{String}, load_path::Vector{String}, concrete_deps::Vector{Pair{Base.PkgId, UInt64}}, source::String)                                                 
   @ Base ./loading.jl:1554
 [7] top-level scope
   @ stdin:1
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/src/traits.jl:260
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
in expression starting at stdin:1
ERROR: LoadError: Failed to precompile StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc] to /Users/anthony/.julia/compiled/v1.8/StatisticalMeasuresBase/jl_T9sJdn.
Stacktrace:
  [1] error(s::String)
    @ Base ./error.jl:35
  [2] compilecache(pkg::Base.PkgId, path::String, internal_stderr::IO, internal_stdout::IO, 
keep_loaded_modules::Bool)                                                                 
    @ Base ./loading.jl:1707
  [3] compilecache
    @ ./loading.jl:1651 [inlined]
  [4] _require(pkg::Base.PkgId)
    @ Base ./loading.jl:1337
  [5] _require_prelocked(uuidkey::Base.PkgId)
    @ Base ./loading.jl:1200
  [6] macro expansion
    @ ./loading.jl:1180 [inlined]
  [7] macro expansion
    @ ./lock.jl:223 [inlined]
  [8] require(into::Module, mod::Symbol)
    @ Base ./loading.jl:1144
  [9] include(fname::String)
    @ Base.MainInclude ./client.jl:476
 [10] top-level scope
    @ REPL[3]:1
in expression starting at /Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl:2

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
[ Info: Precompiling StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc]
┌ Warning: Unable to determine HTML(edit_link = ...) from remote HEAD branch, defaulting to "master".  
│ Calling `git remote` failed with an exception. Set JULIA_DEBUG=Documenter to see the error. 
│ Unless this is due to a configuration error, the relevant variable should be set explicitly.
└ @ Documenter.Utilities ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:822
[ Info: SetupBuildDirectory: setting up build directory.
[ Info: Doctest: running doctests.
[ Info: ExpandTemplates: expanding markdown templates.
┌ Warning: no docs found for 'StatisticalMeasuresBase.kind' in `@docs` block in src/api.md:56-66        
│ ```@docs
│ StatisticalMeasuresBase.is_measure
│ StatisticalMeasuresBase.kind
│ StatisticalMeasuresBase.kind_of_proxy
│ StatisticalMeasuresBase.ground_truth_scitype
│ StatisticalMeasuresBase.supports_weights
│ StatisticalMeasuresBase.supports_class_weights
│ StatisticalMeasuresBase.orientation
│ StatisticalMeasuresBase.external_aggregation_mode
│ StatisticalMeasuresBase.human_name
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregate' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregating' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CrossReferences: building cross-references.
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregate`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregrating(measure)`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.kind`](@ref)' in src/api.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregate`](@ref)' in src/api.md.      
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CheckDocument: running document checks.
┌ Warning: 5 docstrings not included in the manual:
│ 
│     StatisticalMeasuresBase.typename :: Tuple{Any}
│     StatisticalMeasuresBase.can_report_unaggregated :: Tuple{Any}
│     StatisticalMeasuresBase.is_wrapper :: Tuple{Any}
│     StatisticalMeasuresBase.snakecase :: Tuple{AbstractString}
│     StatisticalMeasuresBase.robust_call :: Tuple{Any, Any, Any}
│ 
│ These are docstrings in the checked modules (configured with the modules keyword)
│ that are not included in @docs or @autodocs blocks.
└ @ Documenter.DocChecks ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: Populate: populating indices.
[ Info: RenderDocument: rendering document.
[ Info: HTMLWriter: rendering HTML pages.
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregate")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregrating(measure)")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in api.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.kind")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in api.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregate")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: Documenter could not auto-detect the building environment Skipping deployment.
└ @ Documenter ~/.julia/packages/Documenter/H5y27/src/deployconfig.jl:75

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
┌ Warning: Unable to determine HTML(edit_link = ...) from remote HEAD branch, defaulting to "master".
│ Calling `git remote` failed with an exception. Set JULIA_DEBUG=Documenter to see the error.
│ Unless this is due to a configuration error, the relevant variable should be set explicitly.
└ @ Documenter.Utilities ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:822
[ Info: SetupBuildDirectory: setting up build directory.
[ Info: Doctest: running doctests.
[ Info: ExpandTemplates: expanding markdown templates.
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregate' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregating' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CrossReferences: building cross-references.
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregate`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregrating(measure)`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregate`](@ref)' in src/api.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CheckDocument: running document checks.
┌ Warning: 6 docstrings not included in the manual:
│ 
│     StatisticalMeasuresBase.typename :: Tuple{Any}
│     StatisticalMeasuresBase.is_wrapper :: Tuple{Any}
│     StatisticalMeasuresBase.snakecase :: Tuple{AbstractString}
│     StatisticalMeasuresBase.robust_call :: Tuple{Any, Any, Any}
│     StatisticalMeasuresBase.kind :: Tuple{Any}
│     StatisticalMeasuresBase.name :: Tuple{Any}
│ 
│ These are docstrings in the checked modules (configured with the modules keyword)
│ that are not included in @docs or @autodocs blocks.
└ @ Documenter.DocChecks ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: Populate: populating indices.
[ Info: RenderDocument: rendering document.
[ Info: HTMLWriter: rendering HTML pages.
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregate")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregrating(measure)")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in api.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregate")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: Documenter could not auto-detect the building environment Skipping deployment.
└ @ Documenter ~/.julia/packages/Documenter/H5y27/src/deployconfig.jl:75

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_SizYOZ/Project.toml`
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_SizYOZ/Manifest.toml`
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   ✗ StatisticalMeasuresBase
  0 dependencies successfully precompiled in 2 seconds. 8 already precompiled.
  1 dependency errored. To see a full report either run `import Pkg; Pkg.precompile()` or load the package
     Testing Running tests...
ERROR: LoadError: UndefVarError: API not defined
Stacktrace:
 [1] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:207
 [2] include(mod::Module, _path::String)
   @ Base ./Base.jl:419
 [3] include(x::String)
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
 [4] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:9
 [5] include
   @ ./Base.jl:419 [inlined]
 [6] include_package_for_output(pkg::Base.PkgId, input::String, depot_path::Vector{String}, dl_load_path::Vector{String}, load_path::Vector{String}, concrete_deps::Vector{Pair{Base.PkgId, UInt64}}, source::String)                                                                                                                                                 
   @ Base ./loading.jl:1554
 [7] top-level scope
   @ stdin:1
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:207
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
in expression starting at stdin:1
ERROR: LoadError: Failed to precompile StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc] to /Users/anthony/.julia/compiled/v1.8/StatisticalMeasuresBase/jl_K2da0y.
Stacktrace:
  [1] error(s::String)
    @ Base ./error.jl:35
  [2] compilecache(pkg::Base.PkgId, path::String, internal_stderr::IO, internal_stdout::IO, keep_loaded_modules::Bool)
    @ Base ./loading.jl:1707
  [3] compilecache
    @ ./loading.jl:1651 [inlined]
  [4] _require(pkg::Base.PkgId)
    @ Base ./loading.jl:1337
  [5] _require_prelocked(uuidkey::Base.PkgId)
    @ Base ./loading.jl:1200
  [6] macro expansion
    @ ./loading.jl:1180 [inlined]
  [7] macro expansion
    @ ./lock.jl:223 [inlined]
  [8] require(into::Module, mod::Symbol)
    @ Base ./loading.jl:1144
  [9] include(fname::String)
    @ Base.MainInclude ./client.jl:476
 [10] top-level scope
    @ none:6
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/runtests.jl:1
ERROR: Package StatisticalMeasuresBase errored during testing

(@measure) pkg> st
Status `~/.julia/environments/measure/Project.toml`
  [324d7699] CategoricalArrays v0.10.7
  [e30172f5] Documenter v0.27.24
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`

julia> using StatisticalMeasuresBase

julia> using StatisticalMeasuresBase

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_tvuM0r/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_tvuM0r/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
@trait: Test Failed at /Users/anthony/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:2                  
  Expression: API.is_measure(LPLoss())
Stacktrace:
 [1] macro expansion
   @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464 [inlined]                                                                       
 [2] macro expansion
   @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:2 [inlined]
 [3] macro expansion
   @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:1363 [inlined]                                                                      
 [4] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:2
Test Summary:             | Pass  Fail  Total  Time
tools_for_implementers.jl |    3     1      4  0.9s
  @trait                  |    2     1      3  0.5s
  skipinvalid             |    1            1  0.4s
ERROR: LoadError: Some tests did not pass: 3 passed, 1 failed, 0 errored, 0 broken.
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/runtests.jl:14
ERROR: Package StatisticalMeasuresBase errored during testing

julia> Meta.parse("x=4")
:(x = 4)

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_sQjZDw/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_sQjZDw/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
ERROR: LoadError: MethodError: no method matching push!(::NTuple{4, Expr}, ::Expr)
Closest candidates are:
  push!(::Any, ::Any, ::Any) at abstractarray.jl:3059
  push!(::Any, ::Any, ::Any, ::Any...) at abstractarray.jl:3060
  push!(::Base.InvasiveLinkedList{Base.LinkedListItem{T}}, ::T) where T at linked_list.jl:138                                                        
  ...
Stacktrace:
 [1] var"@trait"(__source__::LineNumberNode, __module__::Module, algorithm_ex::Any, exs::Vararg{Any})                                                                                
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:51
 [2] include(fname::String)
   @ Base.MainInclude ./client.jl:476
 [3] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/test/runtests.jl:8
 [4] include(fname::String)
   @ Base.MainInclude ./client.jl:476
 [5] top-level scope
   @ none:6
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/_measures_for_testing.jl:14
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/_measures_for_testing.jl:14
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/runtests.jl:8
ERROR: Package StatisticalMeasuresBase errored during testing

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_sHmuWO/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_sHmuWO/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
Test Summary:             | Pass  Total  Time
tools_for_implementers.jl |    4      4  0.4s
     Testing StatisticalMeasuresBase tests passed 

julia> using StatisticalMeasuresBase

julia> 

Process julia finished
  Activating project at `~/.julia/environments/work`
Current working directory: docs
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.8.5 (2023-01-08)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> 

(@work) pkg> activate --shared measure
  Activating project at `~/.julia/environments/measure`

julia> using StatisticalMeasuresBase
[ Info: Precompiling StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc]
ERROR: LoadError: SystemError: opening file "/Users/anthony/MLJ/StatisticalMeasuresBase/src/aggregation.jl": No such file or directory
Stacktrace:
  [1] systemerror(p::String, errno::Int32; extrainfo::Nothing)
    @ Base ./error.jl:176
  [2] #systemerror#80
    @ ./error.jl:175 [inlined]
  [3] systemerror
    @ ./error.jl:175 [inlined]
  [4] open(fname::String; lock::Bool, read::Nothing, write::Nothing, create::Nothing, truncate::Nothing, append::Nothing)                                                         
    @ Base ./iostream.jl:293
  [5] open
    @ ./iostream.jl:275 [inlined]
  [6] open(f::Base.var"#387#388"{String}, args::String; kwargs::Base.Pairs{Symbol, Union{}, Tuple{}, NamedTuple{(), Tuple{}}})                                        
    @ Base ./io.jl:382
  [7] open
    @ ./io.jl:381 [inlined]
  [8] read
    @ ./io.jl:462 [inlined]
  [9] _include(mapexpr::Function, mod::Module, _path::String)
    @ Base ./loading.jl:1484
 [10] include(mod::Module, _path::String)
    @ Base ./Base.jl:419
 [11] include(x::String)
    @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
 [12] top-level scope
    @ ~/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:15
 [13] include
    @ ./Base.jl:419 [inlined]
 [14] include_package_for_output(pkg::Base.PkgId, input::String, depot_path::Vector{String}, dl_load_path::Vector{String}, load_path::Vector{String}, concrete_deps::Vector{Pair{Base.PkgId, UInt64}}, source::Nothing)                                                
    @ Base ./loading.jl:1554
 [15] top-level scope
    @ stdin:1
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/src/StatisticalMeasuresBase.jl:1
in expression starting at stdin:1
ERROR: Failed to precompile StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc] to /Users/anthony/.julia/compiled/v1.8/StatisticalMeasuresBase/jl_iJFepJ.
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:35
 [2] compilecache(pkg::Base.PkgId, path::String, internal_stderr::IO, internal_stdout::IO, keep_loaded_modules::Bool)                                                                  
   @ Base ./loading.jl:1707
 [3] compilecache
   @ ./loading.jl:1651 [inlined]
 [4] _require(pkg::Base.PkgId)
   @ Base ./loading.jl:1337
 [5] _require_prelocked(uuidkey::Base.PkgId)
   @ Base ./loading.jl:1200
 [6] macro expansion
   @ ./loading.jl:1180 [inlined]
 [7] macro expansion
   @ ./lock.jl:223 [inlined]
 [8] require(into::Module, mod::Symbol)
   @ Base ./loading.jl:1144

julia> using StatisticalMeasuresBase
[ Info: Precompiling StatisticalMeasuresBase [c062fc1d-0d66-479b-b6ac-8b44719de4cc]

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_G2avE6/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_G2avE6/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
skipinvalid: Error During Test at /Users/anthony/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:8                  
  Test threw exception
  Expression: API.skipinvalid([1, 2, missing, 3, NaN]) == [1, 2, 3]
  MethodError: objects of type Bool are not callable
  Maybe you forgot to use an operator such as *, ^, %, / etc. ?
  Stacktrace:
   [1] skipinvalid(v::Vector{Union{Missing, Float64}}; skipnan::Bool)
     @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:92
   [2] skipinvalid(v::Vector{Union{Missing, Float64}})
     @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:90
   [3] macro expansion
     @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464 [inlined]
   [4] macro expansion
     @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:8 [inlined]
   [5] macro expansion
     @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:1363 [inlined]
   [6] top-level scope
     @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:8
skipinvalid: Test Failed at /Users/anthony/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:9                  
  Expression: API.skipinvalid([1, 2, missing, 3, NaN], skipnan = false) == [1, 2, 3, NaN]
   Evaluated: Union{Missing, Float64}[1.0, 2.0, missing, 3.0, NaN] == [1.0, 2.0, 3.0, NaN]
Stacktrace:
 [1] macro expansion
   @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464 [inlined]                                                                       
 [2] macro expansion
   @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:9 [inlined]
 [3] macro expansion
   @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:1363 [inlined]                                                                      
 [4] top-level scope
   @ ~/MLJ/StatisticalMeasuresBase/test/tools_for_implementers.jl:8
Test Summary:             | Pass  Fail  Error  Total  Time
tools_for_implementers.jl |    4     1      1      6  2.1s
  @trait                  |    3                   3  0.0s
  skipinvalid             |    1     1      1      3  2.1s
ERROR: LoadError: Some tests did not pass: 4 passed, 1 failed, 1 errored, 0 broken.
in expression starting at /Users/anthony/MLJ/StatisticalMeasuresBase/test/runtests.jl:14
ERROR: Package StatisticalMeasuresBase errored during testing

julia> API = StatisticalMeasuresBase
StatisticalMeasuresBase

julia> API.skipinvalid([1, 2, missing, 3, NaN])
ERROR: MethodError: objects of type Bool are not callable
Maybe you forgot to use an operator such as *, ^, %, / etc. ?
Stacktrace:
 [1] skipinvalid(v::Vector{Union{Missing, Float64}}; skipnan::Bool)
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:92
 [2] skipinvalid(v::Vector{Union{Missing, Float64}})
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:90
 [3] top-level scope
   @ REPL[5]:1

julia> API.skipinvalid([1, 2, missing, 3, NaN])
ERROR: MethodError: objects of type Bool are not callable
Maybe you forgot to use an operator such as *, ^, %, / etc. ?
Stacktrace:
 [1] skipinvalid(v::Vector{Union{Missing, Float64}}; skipnan::Bool)
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:92
 [2] skipinvalid(v::Vector{Union{Missing, Float64}})
   @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:90
 [3] top-level scope
   @ REPL[5]:1

julia> API.skipinvalid([1, 2, missing, 3, NaN])
Base.Iterators.Filter{Base.var"#97#98"{typeof(StatisticalMeasuresBase._isnan)}, Base.SkipMissing{Vector{Union{Missing, Float64}}}}(Base.var"#97#98"{typeof(StatisticalMeasuresBase._isnan)}(StatisticalMeasuresBase._isnan), skipmissing(Union{Missing, Float64}[1.0, 2.0, missing, 3.0, NaN]))                          

julia> collect(ans)
3-element Vector{Float64}:
 1.0
 2.0
 3.0

julia> @test API.skipinvalid([1, 2, missing, 3, NaN]) == [1 ,2, 3]
Test Failed at REPL[7]:1
  Expression: API.skipinvalid([1, 2, missing, 3, NaN]) == [1, 2, 3]
   Evaluated: Base.Iterators.Filter{Base.var"#97#98"{typeof(StatisticalMeasuresBase._isnan)}, Base.SkipMissing{Vector{Union{Missing, Float64}}}}(Base.var"#97#98"{typeof(StatisticalMeasuresBase._isnan)}(StatisticalMeasuresBase._isnan), skipmissing(Union{Missing, Float64}[1.0, 2.0, missing, 3.0, NaN])) == [1, 2, 3]
ERROR: There was an error during testing

julia> @test collect(API.skipinvalid([1, 2, missing, 3, NaN])) == [1 ,2, 3]
Test Passed

julia> @test API.skipinvalid([1, 2, missing, 3, NaN], skipnan=false) == [1 ,2, 3, NaN]
Test Failed at REPL[9]:1
  Expression: API.skipinvalid([1, 2, missing, 3, NaN], skipnan = false) == [1, 2, 3, NaN]
   Evaluated: skipmissing(Union{Missing, Float64}[1.0, 2.0, missing, 3.0, NaN]) == [1.0, 2.0, 3.0, NaN]
ERROR: There was an error during testing

julia> @test collect(API.skipinvalid([1, 2, missing, 3, NaN], skipnan=false)) ==
       [1 ,2, 3, NaN]
Test Failed at REPL[10]:1
  Expression: collect(API.skipinvalid([1, 2, missing, 3, NaN], skipnan = false)) == [1, 2, 3, NaN]
   Evaluated: [1.0, 2.0, 3.0, NaN] == [1.0, 2.0, 3.0, NaN]
ERROR: There was an error during testing

julia> NaN == NaN
false

julia> want = [1, 2, 3, NaN]
4-element Vector{Float64}:
   1.0
   2.0
   3.0
 NaN

julia> got = collect(API.skipinvalid([1, 2, missing, 3, NaN], skipnan=false))
4-element Vector{Float64}:
   1.0
   2.0
   3.0
 NaN

julia> @test want[1:3] == got[1:3]
Test Passed

julia> @test isnan(got[1:3])
Error During Test at REPL[15]:1
  Test threw exception
  Expression: isnan(got[1:3])
  MethodError: no method matching isnan(::Vector{Float64})
  Closest candidates are:
    isnan(::Complex) at complex.jl:147
    isnan(::Missing) at missing.jl:101
    isnan(::BigFloat) at mpfr.jl:904
    ...
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247        
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test isnan(got[4])
Test Passed

julia> @test API.skipinvalid([1, 2, missing, 3, NaN], [missing, 5, 6, 7, 8]) ==
       ([2, 3], [5, 7])
Test Passed

julia> want = ([2, 3, NaN)], [5, 7, 8])
ERROR: syntax: missing separator in array expression
Stacktrace:
 [1] top-level scope
   @ none:1

julia> want = ([2, 3, NaN)], [5, 7, 8])
ERROR: syntax: missing separator in array expression
Stacktrace:
 [1] top-level scope
   @ none:1

julia> want = ([2, 3, NaN], [5, 7, 8])
([2.0, 3.0, NaN], [5, 7, 8])

julia> got = API.skipinvalid([1, 2, missing, 3, NaN], [missing, 5, 6, 7, 8], skipnan=false)
(Union{Missing, Float64}[2.0, 3.0, NaN], Union{Missing, Int64}[5, 7, 8])

julia> @test want[2] == got[2]
Test Passed

julia> @test want[1][1:2] == got[1][1:2]
Test Passed

julia> @test isnana(got[1][3])
Error During Test at REPL[23]:1
  Test threw exception
  Expression: isnana((got[1])[3])
  UndefVarError: isnana not defined
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test isnan(got[1][3])
Test Passed

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_ZLhEqz/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_ZLhEqz/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
Test Summary:             | Pass  Total  Time
tools_for_implementers.jl |   10     10  0.7s
     Testing StatisticalMeasuresBase tests passed 

(@measure) pkg> e = Int[]
ERROR: `e` is not a recognized command. Type ? for help with available commands

(@measure) pkg> v =[1, 2, missing, 5, NaN]
ERROR: `v` is not a recognized command. Type ? for help with available commands

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_ettL30/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_ettL30/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
Test Summary:             | Pass  Total  Time
tools_for_implementers.jl |   10     10  0.8s
     Testing StatisticalMeasuresBase tests passed 

julia> v =[1, 2, missing, 5, NaN]
5-element Vector{Union{Missing, Float64}}:
   1.0
   2.0
    missing
   5.0
 NaN

julia> e = Int[]
Int64[]

julia> @test aggregate(Sum(), v) == NaN
Test Failed at REPL[31]:1
  Expression: aggregate(Sum(), v) == NaN
   Evaluated: NaN == NaN
ERROR: There was an error during testing

julia> @test isnan(aggregate(Sum(), v))
Test Passed

julia> @test aggregate(Sum(), v; skipnan=true) == 8
Test Passed

julia> @test aggregate(Sum(), v, (i for i in 1:5), skipnan=true) == 25
Error During Test at REPL[34]:1
  Test threw exception
  Expression: aggregate(Sum(), v, (i for i = 1:5), skipnan = true) == 25
  UndefVarError: measuresments not defined
  Stacktrace:
    [1] aggregate(::Sum, measurements::Vector{Union{Missing, Float64}}, weights::Base.Generator{UnitRange{Int64}, typeof(identity)}; skipnan::Bool)                          
      @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:40
    [2] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [3] eval
      @ ./boot.jl:368 [inlined]
    [4] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [5] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [6] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [7] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [8] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [9] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
   [10] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [11] invokelatest
      @ ./essentials.jl:726 [inlined]
   [12] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [13] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [14] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test aggregate(Sum(), v, (i for i in 1:5), skipnan=true) == 25
Error During Test at REPL[34]:1
  Test threw exception
  Expression: aggregate(Sum(), v, (i for i = 1:5), skipnan = true) == 25
  MethodError: no method matching getindex(::Base.Generator{UnitRange{Int64}, typeof(identity)}, ::BitVector)
  Stacktrace:
    [1] skipinvalid(yhat::Vector{Union{Missing, Float64}}, y::Base.Generator{UnitRange{Int64}, typeof(identity)}; skipnan::Bool)                                        
      @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/tools_for_implementers.jl:98
    [2] aggregate(::Sum, measurements::Vector{Union{Missing, Float64}}, weights::Base.Generator{UnitRange{Int64}, typeof(identity)}; skipnan::Bool)                          
      @ StatisticalMeasuresBase ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:40
    [3] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [4] eval
      @ ./boot.jl:368 [inlined]
    [5] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [6] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [7] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232                
    [8] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [9] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
   [10] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
   [11] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [12] invokelatest
      @ ./essentials.jl:726 [inlined]
   [13] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [14] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [15] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> collect(rand(2,3))
2×3 Matrix{Float64}:
 0.0185182  0.754016  0.780851
 0.519156   0.37484   0.616737

julia> [rand(2,3)...]
6-element Vector{Float64}:
 0.031214948863319547
 0.3218943804137704
 0.28184708021954663
 0.19779947670607279
 0.8751606675015399
 0.24756105089028368

julia> _isnan(x) = false
_isnan (generic function with 1 method)

julia> _isnan(x::Number) = isnan(x)
_isnan (generic function with 2 methods)

julia> 

julia> skipnan(x) = Iterators.filter(!_isnan, x)
skipnan (generic function with 1 method)

julia> skipnan=true
ERROR: invalid redefinition of constant skipnan
Stacktrace:
 [1] top-level scope
   @ REPL[40]:1

julia> isbad = ismissing
ismissing (generic function with 1 method)

julia> y = (i for i in 1:3)
Base.Generator{UnitRange{Int64}, typeof(identity)}(identity, 1:3)

julia> isbad .(y)
ERROR: syntax: space before "." not allowed in "isbad ." at REPL[43]:1
Stacktrace:
 [1] top-level scope
   @ none:1

julia> isbad.(y)
3-element BitVector:
 0
 0
 0

julia> @test aggregate(Sum(), v, (i for i in 1:5), skipnan=true) == 25
Test Passed

julia> @test aggregate(TruePositive(), v) == 8
Error During Test at REPL[46]:1
  Test threw exception
  Expression: aggregate(TruePositive(), v) == 8
  UndefVarError: TruePositive not defined
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> struct TruePositive end

julia> @trait(
           TruePositive,
           can_report_unaggregated = true,
           kind_of_proxy = LiteralTarget(),
           ground_truth_scitype = Union{OrderedFactor,Missing},
           orientation = API.Score(),
           external_aggregation_mode = API.Sum(),
           orientation = API.Loss(),
       )

julia> function raw_call(::TruePositive, ŷ, y)
           positive_class = last(levels(y))
           (ŷ .== positive_class) .& (ŷ .== y) |> skipinvalid |> sum
       end
raw_call (generic function with 1 method)

julia> @test aggregate(TruePositive(), v) == 8
Test Failed at REPL[50]:1
  Expression: aggregate(TruePositive(), v) == 8
   Evaluated: NaN == 8
ERROR: There was an error during testing

julia> @test aggregate(TruePositive(), v; skipnan=true) == 8
Error During Test at REPL[51]:1
  Test threw exception
  Expression: aggregate(TruePositive(), v; skipnan = true) == 8
  MethodError: no method matching aggregate(::TruePositive, ::Vector{Union{Missing, Float64}}; skipnan=true)
  Closest candidates are:
    aggregate(::Any, ::Any...) at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:29 got unsupported keyword argument "skipnan"                                                 
    aggregate(::Mean, ::AbstractVector{T}) where T at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:45 got unsupported keyword argument "skipnan"
    aggregate(::Mean, ::AbstractVector{T}, ::Any; skipnan) where T at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:45                    
    ...
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369                      
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test aggregate(TruePositive(), v; skipnan=true) == 8
Error During Test at REPL[51]:1
  Test threw exception
  Expression: aggregate(TruePositive(), v; skipnan = true) == 8
  MethodError: no method matching aggregate(::TruePositive, ::Vector{Union{Missing, Float64}}; skipnan=true)
  Closest candidates are:
    aggregate(::Any, ::Any...) at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:29 got unsupported keyword argument "skipnan"                                                 
    aggregate(::Mean, ::AbstractVector{T}) where T at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:45 got unsupported keyword argument "skipnan"
    aggregate(::Mean, ::AbstractVector{T}, ::Any; skipnan) where T at ~/MLJ/StatisticalMeasuresBase/src/aggregation.jl:45                    
    ...
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test aggregate(TruePositive(), v; skipnan=true) == 8
Test Passed

julia> @test aggregate(TruePositive(), v; skipnan=true) == 8
Test Passed

julia> @test aggregate(LPLoss(), v; skipnan=true) == mean(1, 2, 5)
Error During Test at REPL[52]:1
  Test threw exception
  Expression: aggregate(LPLoss(), v; skipnan = true) == mean(1, 2, 5)
  UndefVarError: LPLoss not defined
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> include("/Users/anthony/MLJ/StatisticalMeasuresBase/test/_measures_for_testing.jl");

julia> @test aggregate(LPLoss(), v; skipnan=true) == mean(1, 2, 5)
Error During Test at REPL[54]:1
  Test threw exception
  Expression: aggregate(LPLoss(), v; skipnan = true) == mean(1, 2, 5)
  UndefVarError: mean not defined
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> using Statistics

julia> @test aggregate(LPLoss(), v; skipnan=true) == mean(1, 2, 5)
Error During Test at REPL[56]:1
  Test threw exception
  Expression: aggregate(LPLoss(), v; skipnan = true) == mean(1, 2, 5)
  MethodError: no method matching mean(::Int64, ::Int64, ::Int64)
  Closest candidates are:
    mean(::Any, ::Any) at /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Statistics/src/Statistics.jl:61
    mean(::Any) at /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Statistics/src/Statistics.jl:44
    mean(::Any, ::AbstractArray; dims) at /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Statistics/src/Statistics.jl:104
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> @test aggregate(LPLoss(), v; skipnan=true) == mean([1, 2, 5])
Test Passed

julia> @test aggregate(LPLoss(), v, w; skipnan=true) ≈ (1*1 + 2*2 + 4*5)/(1 + 2 + 3)
Error During Test at REPL[58]:1
  Test threw exception
  Expression: aggregate(LPLoss(), v, w; skipnan = true) ≈ (1 * 1 + 2 * 2 + 4 * 5) / (1 + 2 + 3)
  UndefVarError: w not defined
  Stacktrace:
    [1] top-level scope
      @ /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/Test/src/Test.jl:464
    [2] eval
      @ ./boot.jl:368 [inlined]
    [3] eval_user_input(ast::Any, backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:151
    [4] repl_backend_loop(backend::REPL.REPLBackend)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:247                                                        
    [5] start_repl_backend(backend::REPL.REPLBackend, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:232
    [6] run_repl(repl::AbstractREPL, consumer::Any; backend_on_current_task::Bool)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:369
    [7] run_repl(repl::AbstractREPL, consumer::Any)
      @ REPL /Applications/Julia-1.8.app/Contents/Resources/julia/share/julia/stdlib/v1.8/REPL/src/REPL.jl:355
    [8] (::Base.var"#967#969"{Bool, Bool, Bool})(REPL::Module)
      @ Base ./client.jl:419
    [9] #invokelatest#2
      @ ./essentials.jl:729 [inlined]
   [10] invokelatest
      @ ./essentials.jl:726 [inlined]
   [11] run_main_repl(interactive::Bool, quiet::Bool, banner::Bool, history_file::Bool, color_set::Bool)                                                                            
      @ Base ./client.jl:404
   [12] exec_options(opts::Base.JLOptions)
      @ Base ./client.jl:318
   [13] _start()
      @ Base ./client.jl:522
ERROR: There was an error during testing

julia> w = (i for i in 1:5)
Base.Generator{UnitRange{Int64}, typeof(identity)}(identity, 1:5)

julia> @test isnan(aggregate(Sum(), v))
Test Passed

julia> @test aggregate(Sum(), v; skipnan=true) == 8
Test Passed

julia> @test aggregate(Sum(), v, w, skipnan=true) == 25
Test Passed

julia> @test aggregate(TruePositive(), v; skipnan=true) == 8
Test Passed

julia> @test aggregate(LPLoss(), v; skipnan=true) == mean([1, 2, 5])
Test Passed

julia> @test aggregate(LPLoss(), v, w; skipnan=true) ≈ (1*1 + 2*2 + 4*5)/(1 + 2 + 3)
Test Failed at REPL[65]:1
  Expression: aggregate(LPLoss(), v, w; skipnan = true) ≈ (1 * 1 + 2 * 2 + 4 * 5) / (1 + 2 + 3)
   Evaluated: 3.5714285714285716 ≈ 4.166666666666667
ERROR: There was an error during testing

julia> @test aggregate(LPLoss(), v, w; skipnan=true) ≈ (1*1 + 2*2 + 4*5)/(1 + 2 + 4)
Test Passed

julia> @test aggregate(Sum(), e) == 0
Test Passed

julia> @testset "sum" begin
           @test isnan(aggregate(Sum(), v))
           @test aggregate(Sum(), v; skipnan=true) == 8
           @test aggregate(Sum(), v, w, skipnan=true) == 25
           @test aggregate(TruePositive(), v; skipnan=true) == 8
           @test aggregate(Sum(), e) == 0
           @test aggregate(Sum(), e) == 0
       end
Test Summary: | Pass  Total  Time
sum           |    6      6  0.0s
Test.DefaultTestSet("sum", Any[], 6, false, false, true, 1.678918444659388e9, 1.67891844468916e9)                      

julia> @test isnan(aggregate(Mean(), v))
Test Passed

julia> @test aggregate(Mean(), v; skipnan=true) ≈ 8/3
Test Passed

julia> @test isnan(aggregate(Sum(), v))
Test Passed

julia> @test aggregate(Sum(), v; skipnan=true) == 14
Test Failed at REPL[72]:1
  Expression: aggregate(Sum(), v; skipnan = true) == 14
   Evaluated: 8.0 == 14
ERROR: There was an error during testing

julia> @test aggregate(Sum(), v; skipnan=true) == 14
Test Failed at REPL[72]:1
  Expression: aggregate(Sum(), v; skipnan = true) == 14
   Evaluated: 8.0 == 14
ERROR: There was an error during testing

julia> v =[2, 7, missing, 5, NaN]
5-element Vector{Union{Missing, Float64}}:
   2.0
   7.0
    missing
   5.0
 NaN

julia> w = (i for i in 1:5)
Base.Generator{UnitRange{Int64}, typeof(identity)}(identity, 1:5)

julia> e = Int[]
Int64[]

julia> @test isnan(aggregate(Sum(), v))
Test Passed

julia> @test aggregate(Sum(), v; skipnan=true) == 14
Test Passed

julia> @test aggregate(Sum(), v, w, skipnan=true) == 1*2 + 2*7 + 4*5
Test Passed

julia> @test aggregate(TruePositive(), v; skipnan=true) == 14
Test Passed

julia> @test aggregate(Sum(), e) == 0
Test Passed

julia> @test aggregate(Sum(), e) == 0
Test Passed

julia> @test aggregate(Mean(), v; skipnan=true) ≈ 14/3
Test Passed

julia> @test aggregate(Mean(), v, w, skipnan=true) == (1*2 + 2*7 + 4*5)/(1 + 2 + 4)
Test Passed

julia> @test aggregate(LPLoss(), v; skipnan=true) == 14/3
Test Passed

julia> @test aggregate(Mean(), e) |> isnan
Test Passed

julia> @test aggregate(RootMean(), v; skipnan=true) ≈ sqrt((4 + 49 + 25)/3)
Test Failed at REPL[85]:1
  Expression: aggregate(RootMean(), v; skipnan = true) ≈ sqrt((4 + 49 + 25) / 3)
   Evaluated: 4.666666666666667 ≈ 5.0990195135927845
ERROR: There was an error during testing

julia> @test aggregate(RootMean(), v; skipnan=true) ≈ sqrt((4 + 49 + 25)/3)
Test Passed

julia> @test aggregate(RootMean(), v, w, skipnan=true) ==
       sqrt((1*4 + 2*49 + 4*25)/(1 + 2 + 4))
Test Passed

julia> @test aggregate(RootMean(), e) |> isnan
Test Passed

julia> 1/2.5
0.4

julia> @test aggregate(RootMean(2.5), v; skipnan=true) ≈ sum([2, 7, 5].^2.5)^0.4
Test Failed at REPL[89]:1
  Expression: aggregate(RootMean(2.5), v; skipnan = true) ≈ sum([2, 7, 5] .^ 2.5) ^ 0.4
   Evaluated: 5.269227959143123 ≈ 8.177028086347319
ERROR: There was an error during testing

julia> @test aggregate(RootMean(2.5), v; skipnan=true) ≈ mean([2, 7, 5].^2.5)^0.4
Test Passed

julia> include("/Users/anthony/MLJ/StatisticalMeasuresBase/test/aggregation.jl");
Test Summary: | Pass  Total  Time
Sum()         |    5      5  0.0s
Test Summary: | Pass  Total  Time
Mean()        |    5      5  0.0s
Test Summary: | Pass  Total  Time
RootMean()    |    4      4  0.0s
Test Summary: | Pass  Total  Time
RootMean(2.5) |    2      2  0.0s

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_R5ldfL/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_R5ldfL/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
Test Summary:             | Pass  Total  Time
tools_for_implementers.jl |   10     10  0.8s
Test Summary:  | Pass  Total  Time
aggregation.jl |   16     16  0.9s
     Testing StatisticalMeasuresBase tests passed 

(@measure) pkg> end
ERROR: `end` is not a recognized command. Type ? for help with available commands

(@measure) pkg> end
ERROR: `end` is not a recognized command. Type ? for help with available commands

(@measure) pkg> test StatisticalMeasuresBase
     Testing StatisticalMeasuresBase
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_QJvpel/Project.toml`          
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
      Status `/private/var/folders/4n/gvbmlhdc8xj973001s6vdyw00000gq/T/jl_QJvpel/Manifest.toml`         
  [324d7699] CategoricalArrays v0.10.7
  [9a962f9c] DataAPI v1.14.0
  [e1d29d7a] Missings v1.1.0
  [ae029012] Requires v1.3.0
  [30f210dd] ScientificTypesBase v3.0.0
  [c062fc1d] StatisticalMeasuresBase v0.1.0 `~/MLJ/StatisticalMeasuresBase`
  [56f22d72] Artifacts `@stdlib/Artifacts`
  [2a0f44e3] Base64 `@stdlib/Base64`
  [9fa8497b] Future `@stdlib/Future`
  [b77e0a4c] InteractiveUtils `@stdlib/InteractiveUtils`
  [8f399da3] Libdl `@stdlib/Libdl`
  [37e2e46d] LinearAlgebra `@stdlib/LinearAlgebra`
  [56ddb016] Logging `@stdlib/Logging`
  [d6f4376e] Markdown `@stdlib/Markdown`
  [de0858da] Printf `@stdlib/Printf`
  [9a3f8284] Random `@stdlib/Random`
  [ea8e919c] SHA v0.7.0 `@stdlib/SHA`
  [9e88b42a] Serialization `@stdlib/Serialization`
  [2f01184e] SparseArrays `@stdlib/SparseArrays`
  [10745b16] Statistics `@stdlib/Statistics`
  [8dfed614] Test `@stdlib/Test`
  [cf7118a7] UUIDs `@stdlib/UUIDs`
  [4ec0a83e] Unicode `@stdlib/Unicode`
  [e66e0078] CompilerSupportLibraries_jll v1.0.1+0 `@stdlib/CompilerSupportLibraries_jll`
  [4536629a] OpenBLAS_jll v0.3.20+0 `@stdlib/OpenBLAS_jll`
  [8e850b90] libblastrampoline_jll v5.1.1+0 `@stdlib/libblastrampoline_jll`
Precompiling project...
   1 dependency successfully precompiled in 1 seconds. 8 already precompiled.
  1 dependency precompiled but a different version is currently loaded. Restart julia to access the new version
     Testing Running tests...
Test Summary: | Pass  Total  Time
tools.jl      |    6      6  0.1s
Test Summary:             | Pass  Total  Time
tools_for_implementers.jl |   10     10  0.8s
Test Summary:  | Pass  Total  Time
aggregation.jl |   16     16  1.0s
     Testing StatisticalMeasuresBase tests passed 

julia> include("/Users/anthony/MLJ/StatisticalMeasuresBase/test/_measures_for_testing.jl");

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
┌ Warning: Unable to determine HTML(edit_link = ...) from remote HEAD branch, defaulting to "master".  
│ Calling `git remote` failed with an exception. Set JULIA_DEBUG=Documenter to see the error. 
│ Unless this is due to a configuration error, the relevant variable should be set explicitly.
└ @ Documenter.Utilities ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:822
[ Info: SetupBuildDirectory: setting up build directory.
[ Info: Doctest: running doctests.
[ Info: ExpandTemplates: expanding markdown templates.
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregating' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CrossReferences: building cross-references.
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregrating(measure)`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CheckDocument: running document checks.
┌ Warning: 6 docstrings not included in the manual:
│ 
│     StatisticalMeasuresBase.robust_call :: Tuple{Any, Any, Any}
│     StatisticalMeasuresBase.kind :: Tuple{Any}
│     StatisticalMeasuresBase.name :: Tuple{Any}
│     StatisticalMeasuresBase.typename :: Tuple{Any}
│     StatisticalMeasuresBase.is_wrapper :: Tuple{Any}
│     StatisticalMeasuresBase.snakecase :: Tuple{AbstractString}
│ 
│ These are docstrings in the checked modules (configured with the modules keyword)
│ that are not included in @docs or @autodocs blocks.
└ @ Documenter.DocChecks ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: Populate: populating indices.
[ Info: RenderDocument: rendering document.
[ Info: HTMLWriter: rendering HTML pages.
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregrating(measure)")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: Documenter could not auto-detect the building environment Skipping deployment.
└ @ Documenter ~/.julia/packages/Documenter/H5y27/src/deployconfig.jl:75

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
┌ Warning: Unable to determine HTML(edit_link = ...) from remote HEAD branch, defaulting to "master".  
│ Calling `git remote` failed with an exception. Set JULIA_DEBUG=Documenter to see the error. 
│ Unless this is due to a configuration error, the relevant variable should be set explicitly.
└ @ Documenter.Utilities ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:822
[ Info: SetupBuildDirectory: setting up build directory.
[ Info: Doctest: running doctests.
[ Info: ExpandTemplates: expanding markdown templates.
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregating' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CrossReferences: building cross-references.
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregrating(measure)`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34                                                                      
[ Info: CheckDocument: running document checks.
┌ Warning: 6 docstrings not included in the manual:
│ 
│     StatisticalMeasuresBase.robust_call :: Tuple{Any, Any, Any}
│     StatisticalMeasuresBase.kind :: Tuple{Any}
│     StatisticalMeasuresBase.name :: Tuple{Any}
│     StatisticalMeasuresBase.typename :: Tuple{Any}
│     StatisticalMeasuresBase.is_wrapper :: Tuple{Any}
│     StatisticalMeasuresBase.snakecase :: Tuple{AbstractString}
│ 
│ These are docstrings in the checked modules (configured with the modules keyword)
│ that are not included in @docs or @autodocs blocks.
└ @ Documenter.DocChecks ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: Populate: populating indices.
[ Info: RenderDocument: rendering document.
[ Info: HTMLWriter: rendering HTML pages.
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregrating(measure)")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: Documenter could not auto-detect the building environment Skipping deployment.
└ @ Documenter ~/.julia/packages/Documenter/H5y27/src/deployconfig.jl:75

julia> include("/Users/anthony/GoogleDrive/Julia/MLJ/StatisticalMeasuresBase/docs/make.jl");
┌ Warning: Unable to determine HTML(edit_link = ...) from remote HEAD branch, defaulting to "master".
│ Calling `git remote` failed with an exception. Set JULIA_DEBUG=Documenter to see the error.
│ Unless this is due to a configuration error, the relevant variable should be set explicitly.
└ @ Documenter.Utilities ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:822
[ Info: SetupBuildDirectory: setting up build directory.
[ Info: Doctest: running doctests.
[ Info: ExpandTemplates: expanding markdown templates.
┌ Warning: undefined binding 'StatisticalMeasuresBase.aggregating' in `@docs` block in src/functionality.md:11-15
│ ```@docs
│ StatisticalMeasuresBase.call
│ StatisticalMeasuresBase.aggregate
│ StatisticalMeasuresBase.aggregating
│ ```
└ @ Documenter.Expanders ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CrossReferences: building cross-references.
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.aggregrating(measure)`](@ref)' in src/functionality.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
┌ Warning: no doc found for reference '[`StatisticalMeasuresBase.is_wrapper`](@ref)' in src/api.md.
└ @ Documenter.CrossReferences ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: CheckDocument: running document checks.
┌ Warning: 6 docstrings not included in the manual:
│ 
│     StatisticalMeasuresBase.robust_call :: Tuple{Any, Any, Any}
│     StatisticalMeasuresBase.kind :: Tuple{Any}
│     StatisticalMeasuresBase.name :: Tuple{Any}
│     StatisticalMeasuresBase.typename :: Tuple{Any}
│     StatisticalMeasuresBase.is_wrapper :: Tuple{Any}
│     StatisticalMeasuresBase.snakecase :: Tuple{AbstractString}
│ 
│ These are docstrings in the checked modules (configured with the modules keyword)
│ that are not included in @docs or @autodocs blocks.
└ @ Documenter.DocChecks ~/.julia/packages/Documenter/H5y27/src/Utilities/Utilities.jl:34
[ Info: Populate: populating indices.
[ Info: RenderDocument: rendering document.
[ Info: HTMLWriter: rendering HTML pages.
┌ Warning: invalid local link: unresolved path in functionality.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.aggregrating(measure)")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: invalid local link: unresolved path in api.md
│   link.text =
│    1-element Vector{Any}:
│     Markdown.Code("", "StatisticalMeasuresBase.is_wrapper")
│   link.url = "@ref"
└ @ Documenter.Writers.HTMLWriter ~/.julia/packages/Documenter/H5y27/src/Writers/HTMLWriter.jl:2081
┌ Warning: Documenter could not auto-detect the building environment Skipping deployment.
└ @ Documenter ~/.julia/packages/Documenter/H5y27/src/deployconfig.jl:75

julia> 
