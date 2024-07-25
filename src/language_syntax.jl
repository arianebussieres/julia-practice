julia

#3.2.1 Variables
name = "Julia"
name
age=9
age
typeof(age)
first(methodswith(Int64), 5)

#3.2.2 User-defined Types
struct Language
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end
fieldnames(Language)
julia = Language("Julia", "Rapidus", 2012, true)
python = Language("Python", "Letargicus", 1991, false)
mutable struct MutableLanguage
    name::String
    title::String
    year_of_birth::Int64
    fast::Bool
end

julia_mutable = MutableLanguage("Julia", "Rapidus", 2012, true)
julia_mutable.title = "Python Obliteratus"
julia_mutable

#3.2.3 Boolean Operators and Numeric Comparisons
    #!: NOT
    #&&: AND
    #||: OR
!true
(false && true) || (!false)
(6 isa Int64) && (6 isa Real)

#3.2.4 Functions
function add_numbers(x, y)
    return x + y
end

add_numbers(17, 29)
add_numbers(3.14, 2.72)

function round_number(x::Float64)
    return round(x)
end
function round_number(x::Int64)
    return x
end
methods(round_number)
function round_number(x::AbstractFloat)
    return round(x)
end

x_32 = Float32(1.1)
round_number(x_32)

Base.show(io::IO, l::Language) = print(
    io, l.name, ", ",
    2024 - l.year_of_birth, " years old, ",
    "has the following titles: ", l.title
)
python

function add_multiply(x, y)
    addition = x + y
    multiplication = x * y
    return addition, multiplication
end

return_1, return_2 = add_multiply(1, 2)
return_2
all_returns = add_multiply(1, 2)
last(all_returns)

function logarithm(x::Real; base::Real=2.7182818284590)
    return log(base, x)
end
logarithm(10)
logarithm(10; base=2)
map(x -> 2.7182818284590^x, logarithm(2))

#3.2.5 Conditional If-Else-Elseif
a = 1
b = 2

if a < b
    "a is less than b"
elseif a > b
    "a is greater than b"
else
    "a is equal to b"
end

function compare(a, b)
    if a < b
        "a is less than b"
    elseif a > b
        "a is greater than b"
    else
        "a is equal to b"
    end
end

compare(3.14, 3.14)

#3.2.6 For Loop
for i in 1:10
    println(i)
end

#3.2.7 While Loop
n = 0

while n < 3
    global n += 1
end

n
