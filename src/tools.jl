"""
    typename(x)

Return a symbolic representation of the name of `type(x)`, stripped of any type-parameters
and module qualifications. For example, if

    typeof(x) = MLJBase.Machine{MLJAlgorithms.ConstantRegressor,true}

Then `typename(x)` returns `:Machine`.

"""
function typename(x)
    M = typeof(x)
    if isdefined(M, :name)
        return M.name.name
    elseif isdefined(M, :body)
        return typename(M.body)
    else
        return Symbol(string(M))
    end
end

function is_uppercase(char::Char)
    i = Int(char)
    i > 64 && i < 91
end

"""
    snakecase(str, del='_')

Return the snake case version of the abstract string or symbol, `str`, as in

    snakecase("TheLASERBeam") == "the_laser_beam"

"""
function snakecase(str::AbstractString; delim='_')
    snake = Char[]
    n = length(str)
    for i in eachindex(str)
        char = str[i]
        if is_uppercase(char)
            if i != 1 && i < n &&
                !(is_uppercase(str[i + 1]) && is_uppercase(str[i - 1]))
                push!(snake, delim)
            end
            push!(snake, lowercase(char))
        else
            push!(snake, char)
        end
    end
    return join(snake)
end

snakecase(s::Symbol) = Symbol(snakecase(string(s)))

_repr_(f::Function) = repr(f)
_repr_(x) = repr("text/plain", x)

