itr =[2.0, 7.0, missing, 5.0, NaN]
weights = (i for i in 1:5)
e = Float32[]
f(x) = 2x

# for testing dictionary aggregation:
d(v) = Dict(x => rand() for x in v)
d1 = d(1:2)
d2 = d(1:2)
ditr = [d1, d2]
w1, w2 = rand(2)
const adict = API.ArithmeticDict
fitr(d) = Dict(k=> 2*d[k] for k in keys(d))

struct FooSum end
API.external_aggregation_mode(::FooSum) = Sum()

struct FooMean end
API.external_aggregation_mode(::FooMean) = IMean()

@testset "Sum()" begin
    @test isnan(aggregate(itr, mode=Sum()))
    @test aggregate(itr; mode=Sum(), skipnan=true) == 14
    @test aggregate(itr; weights, mode=Sum(), skipnan=true) == 1*2 + 2*7 + 4*5
    @test aggregate(itr; mode=FooSum(), skipnan=true) == 14
    @test aggregate(e, mode=Sum()) == 0
    ms = API.weighted(itr; weights, mode=Sum())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [2, 14, 20]

    @test isnan(aggregate(f, itr, mode=Sum()))
    @test aggregate(f, itr; mode=Sum(), skipnan=true) == 28
    @test aggregate(f, itr; weights, mode=Sum(), skipnan=true) == 1*4 + 2*14 + 4*10
    @test aggregate(f, itr; mode=FooSum(), skipnan=true) == 28
    @test aggregate(f, e, mode=Sum()) == 0
    ms = API.weighted(f, itr; weights, mode=Sum())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [4, 28, 40]

    # dictionaries:
    @test aggregate(ditr, mode=Sum())[1] ≈ d1[1] + d2[1]
    @test aggregate(ditr, weights=[w1, w2], mode=Sum())[1] ≈ w1*d1[1] + w2*d2[1]
    ms = API.weighted(ditr, mode=Sum())
    @test length(ms) == 2
    @test ms[2][1] ≈ d2[1]
    ms = API.weighted(ditr, weights=[w1, w2], mode=Sum())
    @test length(ms) == 2
    @test ms[2][1] ≈ w2*d2[1]

    @test aggregate(fitr, ditr, mode=Sum())[1] ≈ 2d1[1] + 2d2[1]
    @test aggregate(fitr, ditr, weights=[w1, w2], mode=Sum())[1] ≈ 2w1*d1[1] + 2w2*d2[1]
    ms = API.weighted(fitr, ditr, mode=Sum())
    @test length(ms) == 2
    @test ms[2][1] ≈ 2d2[1]
    ms = API.weighted(fitr, ditr, weights=[w1, w2], mode=Sum())
    @test length(ms) == 2
    @test ms[2][1] ≈ 2w2*d2[1]
end

@testset "IMean()" begin
    @test isnan(aggregate(itr))
    @test aggregate(itr; skipnan=true) ≈ 14/5
    @test aggregate(itr; weights, skipnan=true, mode=IMean()) ≈
        (1*2 + 2*7 + 4*5)/(1 + 2 + 3 + 4 + 5)
    @test aggregate(itr; mode=FooMean(), skipnan=true) ≈
        14/5
    @test aggregate(e) |> isnan
    ms = API.weighted(itr; weights, mode=IMean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [2, 14, 20]

    @test isnan(aggregate(f, itr))
    @test aggregate(f, itr; skipnan=true, mode=IMean()) ≈ 28/5
    @test aggregate(f, itr; weights, skipnan=true, mode=IMean()) ≈
        (1*4 + 2*14 + 4*10)/(1 + 2 + 3 + 4 + 5)
    @test aggregate(f, itr; mode=FooMean(), skipnan=true) ≈
        28/5
    @test aggregate(f, e) |> isnan
    ms = API.weighted(f, itr; weights, mode=IMean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [4, 28, 40]

    # dictionaries:
    @test aggregate(ditr)[1] ≈ (d1[1] + d2[1])/2
    @test aggregate(ditr, weights=[w1, w2], mode=IMean())[1] ≈
        (w1*d1[1] + w2*d2[1])/(w1 + w2)
    ms = API.weighted(ditr)
    @test length(ms) == 2
    @test ms[2][1] ≈ d2[1]
    ms = API.weighted(ditr, weights=[w1, w2], mode=IMean())
    @test length(ms) == 2
    @test ms[2][1] ≈ w2*d2[1]

    @test aggregate(fitr, ditr, mode=IMean())[1] ≈ (d1[1] + d2[1])
    @test aggregate(fitr, ditr, weights=[w1, w2], mode=IMean())[1] ≈
        2(w1*d1[1] + w2*d2[1])/(w1 + w2)
    ms = API.weighted(fitr, ditr)
    @test length(ms) == 2
    @test ms[2][1] ≈ 2d2[1]
    ms = API.weighted(fitr, ditr, weights=[w1, w2], mode=IMean())
    @test length(ms) == 2
    @test ms[2][1] ≈ 2w2*d2[1]
end

@testset "Mean()" begin
    @test isnan(aggregate(itr))
    @test aggregate(itr; skipnan=true) ≈ 14/5
    @test aggregate(itr; weights, skipnan=true) ≈ (1*2 + 2*7 + 4*5)/5
    @test aggregate(e) |> isnan
    ms = API.weighted(itr; weights, mode=Mean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [2, 14, 20]

    @test isnan(aggregate(f, itr))
    @test aggregate(f, itr; skipnan=true) ≈ 28/5
    @test aggregate(f, itr; weights, skipnan=true) ≈
        (1*4 + 2*14 + 4*10)/5
    @test aggregate(f, e) |> isnan
    ms = API.weighted(f, itr; weights, mode=Mean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [4, 28, 40]

    # dictionaries:
    @test aggregate(ditr)[1] ≈ (d1[1] + d2[1])/2
    @test aggregate(ditr, weights=[w1, w2])[1] ≈ (w1*d1[1] + w2*d2[1])/2
    ms = API.weighted(ditr)
    @test length(ms) == 2
    @test ms[2][1] ≈ d2[1]
    ms = API.weighted(ditr, weights=[w1, w2])
    @test length(ms) == 2
    @test ms[2][1] ≈ w2*d2[1]

    @test aggregate(fitr, ditr)[1] ≈ (d1[1] + d2[1])
    @test aggregate(fitr, ditr, weights=[w1, w2])[1] ≈ 2(w1*d1[1] + w2*d2[1])/2
    ms = API.weighted(fitr, ditr)
    @test length(ms) == 2
    @test ms[2][1] ≈ 2d2[1]
    ms = API.weighted(fitr, ditr, weights=[w1, w2])
    @test length(ms) == 2
    @test ms[2][1] ≈ 2w2*d2[1]
end

@testset "RootMean()" begin
    @test isnan(aggregate(itr, mode=RootMean()))
    @test aggregate(itr; mode=RootMean(), skipnan=true) ≈ sqrt((4 + 49 + 25)/5)
    @test aggregate(itr; weights, mode=RootMean(), skipnan=true) ≈
        sqrt((1*4 + 2*49 + 4*25)/5)
    @test aggregate(e, mode=RootMean()) |> isnan
    ms = API.weighted(itr; weights, mode=RootMean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [sqrt(1)*2, sqrt(2)*7, sqrt(4)*5]

    @test isnan(aggregate(f, itr, mode=RootMean()))
    @test aggregate(f, itr; mode=RootMean(), skipnan=true) ≈ 2*sqrt((4 + 49 + 25)/5)
    @test aggregate(f, itr; weights, mode=RootMean(), skipnan=true) ≈
        2*sqrt((1*4 + 2*49 + 4*25)/5)
    @test aggregate(e, mode=RootMean()) |> isnan
    ms = API.weighted(f, itr; weights, mode=RootMean())
    @test length(ms) == 5
    @test collect(skipmissing(ms))[1:3] ≈ [sqrt(1)*4, sqrt(2)*14, sqrt(4)*10]

    # dictionaries:
    @test aggregate(ditr, mode=RootMean())[1] ≈ (d1[1]^2 + d2[1]^2)/2 |> sqrt
    @test aggregate(ditr, mode=RootMean(), weights=[w1, w2])[1] ≈
        (w1*d1[1]^2 + w2*d2[1]^2)/2 |> sqrt
    ms = API.weighted(ditr, mode=RootMean())
    @test length(ms) == 2
    @test ms[2][1] ≈ d2[1]
    ms = API.weighted(ditr, mode=RootMean(), weights=[w1, w2])
    @test length(ms) == 2
    @test ms[2][1] ≈ sqrt(w2)*d2[1]

    @test aggregate(fitr, ditr, mode=RootMean())[1] ≈ (4d1[1]^2 + 4d2[1]^2)/2 |> sqrt
    @test aggregate(fitr, ditr, mode=RootMean(), weights=[w1, w2])[1] ≈
        (4w1*d1[1]^2 + 4w2*d2[1]^2)/2 |> sqrt
    ms = API.weighted(fitr, ditr, mode=RootMean())
    @test length(ms) == 2
    @test ms[2][1] ≈ 2d2[1]
    ms = API.weighted(fitr, ditr, mode=RootMean(), weights=[w1, w2])
    @test length(ms) == 2
    @test ms[2][1] ≈ 2sqrt(w2)*d2[1]
end

@testset "RootMean(2.5)" begin
    @test isnan(aggregate(itr, mode=RootMean(2.5)))
    @test aggregate(itr; mode=RootMean(2.5), skipnan=true) ≈ sum([2, 7, 5].^2.5 /5)^0.4

    @test isnan(aggregate(f, itr, mode=RootMean(2.5)))
    @test aggregate(f, itr; mode=RootMean(2.5), skipnan=true) ≈
        2*sum([2, 7, 5].^2.5/5)^0.4
end

true
