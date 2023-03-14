@testset "CompositeWeights" begin

    y = [1, 2, missing, 1, 2, 3]
    weights = (i for i in 10:10:60)
    weights3 = Int[]
    weights4 = [1, 2]

    class_weights = Dict(1=>4, 2=>7, 3=>5)

    # no weights:
    @test isnothing(API.CompositeWeights(y))

    # just observation weights:
    @test API.CompositeWeights(y, weights) ==  weights

    # just class weights:
    w = API.CompositeWeights(y, class_weights)
    @test eltype(w) == Int
    @test collect(w) == [4, 7, 0, 4, 7, 5]

    # both class weights and observation weights:
    w = API.CompositeWeights(y, weights, class_weights)
    @test collect(w) == [40, 140, 0, 160, 350, 300]

    # exhaustion:
    @test_throws(
        API.ERR_WEIGHTS_EXHAUSTED,
        collect(API.CompositeWeights(y, weights3,  class_weights)),
    )
    @test_throws(
        API.ERR_WEIGHTS_EXHAUSTED,
        collect(API.CompositeWeights(y, weights4,  class_weights)),
    )

end

true
