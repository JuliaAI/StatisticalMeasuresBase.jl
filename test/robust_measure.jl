y = categorical(["yes", "no", "no"])
yhat = categorical(["no", "yes", "yes"])
w = rand(3)
class_weights = Dict("no" => 1, "yes" => 2, "maybe" => 3)

@testset "calling" begin
    atom = FalsePositive()
    m = robust_measure(atom)
    @test m( y, yhat, w, class_weights) ==
        atom( y, yhat, w, class_weights)
    @test m( y, yhat, w, nothing) ==
        atom( y, yhat, w)
    @test m( y, yhat, nothing, class_weights) ==
        atom( y, yhat, class_weights)
    @test m( y, yhat, nothing, nothing) ==
        atom( y, yhat)

    atom = FalseNegative()
    m = robust_measure(atom)
    @test m( y, yhat, w, class_weights) ==
        atom( y, yhat)
    @test m( y, yhat, w, nothing) ==
        atom( y, yhat)
    @test m( y, yhat, nothing, class_weights) ==
        atom( y, yhat)
    @test m( y, yhat, nothing, nothing) ==
        atom( y, yhat)

    atom = TruePositive()
    m = robust_measure(atom)
    @test m( y, yhat, w, class_weights) ==
        atom( y, yhat, class_weights)
    @test m( y, yhat, w, nothing) ==
        atom( y, yhat)
    @test m( y, yhat, nothing, class_weights) ==
        atom( y, yhat, class_weights)
    @test m( y, yhat, nothing, nothing) ==
        atom( y, yhat)

    atom = TrueNegative()
    m = robust_measure(atom)
    @test m( y, yhat, w, class_weights) ==
        atom( y, yhat, w)
    @test m( y, yhat, w, nothing) ==
        atom( y, yhat, w)
    @test m( y, yhat, nothing, class_weights) ==
        atom( y, yhat)
    @test m( y, yhat, nothing, nothing) ==
        atom( y, yhat)
end 

@testset "measurements" begin
    atom = FalsePositive()
    m = robust_measure(atom)
    @test measurements(m, y, yhat, w, class_weights) ==
        measurements(atom, y, yhat, w, class_weights)
    @test measurements(m, y, yhat, w, nothing) ==
        measurements(atom, y, yhat, w)
    @test measurements(m, y, yhat, nothing, class_weights) ==
        measurements(atom, y, yhat, class_weights)
    @test measurements(m, y, yhat, nothing, nothing) ==
        measurements(atom, y, yhat)

    atom = FalseNegative()
    m = robust_measure(atom)
    @test measurements(m, y, yhat, w, class_weights) ==
        measurements(atom, y, yhat)
    @test measurements(m, y, yhat, w, nothing) ==
        measurements(atom, y, yhat)
    @test measurements(m, y, yhat, nothing, class_weights) ==
        measurements(atom, y, yhat)
    @test measurements(m, y, yhat, nothing, nothing) ==
        measurements(atom, y, yhat)

    atom = TruePositive()
    m = robust_measure(atom)
    @test measurements(m, y, yhat, w, class_weights) ==
        measurements(atom, y, yhat, class_weights)
    @test measurements(m, y, yhat, w, nothing) ==
        measurements(atom, y, yhat)
    @test measurements(m, y, yhat, nothing, class_weights) ==
        measurements(atom, y, yhat, class_weights)
    @test measurements(m, y, yhat, nothing, nothing) ==
        measurements(atom, y, yhat)

    atom = TrueNegative()
    m = robust_measure(atom)
    @test measurements(m, y, yhat, w, class_weights) ==
        measurements(atom, y, yhat, w)
    @test measurements(m, y, yhat, w, nothing) ==
        measurements(atom, y, yhat, w)
    @test measurements(m, y, yhat, nothing, class_weights) ==
        measurements(atom, y, yhat)
    @test measurements(m, y, yhat, nothing, nothing) ==
        measurements(atom, y, yhat)
end

# because we used non-public `call` above, we need to check direct callability:
@test robust_measure(FalsePositive())(yhat, y) == FalsePositive()(yhat, y)

atom = TraitTester(0)
measure =  robust_measure(atom)

@testset "traits" begin
    for trait in API.OVERLOADABLE_TRAITS
        quote
            @test API.$trait(atom) == API.$trait(measure)
        end |> eval
    end
end
