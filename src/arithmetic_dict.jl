nkeys(::LittleDict{K,V,NTuple{N,K},NTuple{N,V}}) where {K,V,N} = N

struct ArithmeticDict{K,V<:Number,N}
    dict::LittleDict{K,V,NTuple{N,K},NTuple{N,V}}
    ArithmeticDict(d::LittleDict{K,V,NTuple{N,K},NTuple{N,V}}) where {K,V,N} =
        new{K,V,N}(d)
    ArithmeticDict(d::AbstractDict{K,V}) where {K,V} =
        (little_d = freeze(d); new{K,V,nkeys(little_d)}(little_d))
end
ArithmeticDict(kys, vls) = ArithmeticDict(LittleDict(kys, vls))

OrderedCollections.LittleDict(d::ArithmeticDict) = d.dict
Base.keys(d::ArithmeticDict) = keys(d.dict)
Base.getindex(d::ArithmeticDict, k) = getindex(d.dict, k)

import Base.(+)
import Base.(*)
import Base.(/)
import Base.(^)
+(d1::ArithmeticDict, d2::ArithmeticDict) =
   ArithmeticDict(Tuple(keys(d1)), Tuple(d1[k] + d2[k] for k in keys(d1)))
*(d1::ArithmeticDict, x::Number) =
    ArithmeticDict(Tuple(keys(d1)), Tuple(d1[k]*x for k in keys(d1)))
*(x::Number, d2::ArithmeticDict) =
    ArithmeticDict(Tuple(keys(d2)), Tuple(x*d2[k] for k in keys(d2)))
/(d1::ArithmeticDict, x::Number) =
    ArithmeticDict(Tuple(keys(d1)), Tuple(d1[k]/x for k in keys(d1)))
^(d1::ArithmeticDict, x::Number) =
    ArithmeticDict(Tuple(keys(d1)), Tuple(d1[k]^x for k in keys(d1)))
