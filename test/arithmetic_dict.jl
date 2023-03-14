pool = ["a", "b"]
dict1 = Dict(p => rand() for p in pool)
dict2 = Dict(p => rand() for p in pool)

d1 = API.ArithmeticDict(dict1)
d2 = API.ArithmeticDict(dict2)
x = 2.3454324

@test all(pool) do p
    (d1 + d2)[p] == d1[p] + d2[p] == dict1[p] + dict2[p]
    (d1*x)[p] == d1[p]*x  == dict1[p]*x
    (x*d1)[p] == (d1*x)[p]
    (d1/x)[p] == d1[p]/x == dict1[p]/x
    (d1^x)[p] == d1[p]^x == dict1[p]^x
end

@test LittleDict(d1) == dict1

true
