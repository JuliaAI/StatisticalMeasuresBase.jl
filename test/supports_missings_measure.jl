measure = API.supports_missings_measure(LPLossOnScalars())

@testset "calling" begin
    @test ismissing(measure(1.0, missing))
    @test ismissing(measure(missing, 1.0))
    @test ismissing(measure(missing, missing))
    @test measure(1.0, 4.5) == lploss(1.0, 4.5)
end

atom = TraitTester(0)
measure =  supports_missings_measure(atom)

@testset "traits" begin
    for trait in setdiff(API.OVERLOADABLE_TRAITS, [:observation_scitype,])
        quote
            @test API.$trait(atom) == API.$trait(measure)
        end |> eval
    end
    @test API.observation_scitype(measure) ==
        Union{Missing,API.observation_scitype(atom)}
end

true
