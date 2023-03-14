module Fruit
using StatisticalMeasuresBase
import StatisticalMeasuresBase as API

struct RedApple{T}
    x::T
end

end

import .Fruit

@testset "typename" begin
    @test API.typename(Fruit.RedApple(4)) == :RedApple
    @test API.typename(Fruit.RedApple(4.5)) == :RedApple
    @test API.typename(nothing) == :Nothing
end

@testset "snakecase" begin
    @test API.snakecase("AnthonyBlaomsPetElk") ==
        "anthony_blaoms_pet_elk"
    @test API.snakecase("TheLASERBeam", delim=' ') ==
        "the laser beam"
    @test API.snakecase(:TheLASERBeam) == :the_laser_beam
end

true
