julia

#3.3.2 Functions with a bang ! 
function add_one!(V)
    for i in eachindex(V)
        V[i] += 1
    end
    return nothing
end
my_data = [1, 2, 3]
add_one!(my_data)
my_data

#3.3.4 Tuple
my_tuple = (1, 3.14, "Julia")
my_tuple[2]

map((x, y) -> x^y, 2, 3)
map((x, y, z) -> x^y + z, 2, 3, 1)

i = 1
f = 3.14
s = "Julia"
my_quick_namedtuple = (; i, f, s)

#3.3.6 Ranges
0.0:0.2:1.0
collect(0.0:0.2:1.0)

#3.3.7 Array
my_vector = Vector{Float64}(undef, 10)
my_matrix = Matrix{Float64}(undef, 10, 2)
my_matrix_zeros = zeros(Int64, 10, 2)

my_matrix_π = Matrix{Float64}(undef, 2, 2)
fill!(my_matrix_π, 3.14)

[x^2 for x in 1:10 if isodd(x)]

cat(ones(2), zeros(2), dims=2)
hcat(ones(2), zeros(2))

eltype(my_matrix_π)
length(my_matrix_π)
ndims(my_matrix_π)
size(my_matrix_π)

 #3.3.7.4 Array Indexing and Slicing
my_example_vector = [1, 2, 3, 4, 5]
my_example_matrix = [[1 2 3]
                     [4 5 6]
                     [7 8 9]]
my_example_vector[2:4]
my_example_matrix[2, :]

 #3.3.7.5 Array Manipulations
my_example_matrix[3, :] = [17, 16, 15]
my_example_matrix

six_vector = [1, 2, 3, 4, 5, 6]
three_two_matrix = reshape(six_vector, (3, 2))
three_two_matrix
reshape(three_two_matrix, (6, ))

my_example_matrix .+ 100
map(x -> 3x, my_example_matrix)
map(x -> x + 100, my_example_matrix[:, 3])

    #rows
mapslices(sum, my_example_matrix; dims=1)
    #columns
mapslices(sum, my_example_matrix; dims=2)

simple_vector = [1, 2, 3]
empty_vector = Int64[]
for i in simple_vector
    push!(empty_vector, i + 1)
end
empty_vector

forty_twos = [42, 42, 42]
empty_vector = Int64[]
for i in eachindex(forty_twos)
    push!(empty_vector, i)
end
empty_vector

column_major = [[1 3]
                [2 4]]

row_major = [[1 2]
             [3 4]]
indexes = Int64[]
for i in column_major
    push!(indexes, i)
end
indexes

indexes = Int64[]
for i in row_major
    push!(indexes, i)
end
indexes

first(eachcol(column_major))
first(eachrow(column_major))

#3.3.8 Pair
my_pair = "Julia" => 42
my_pair.first
first(my_pair)

#3.3.9 Dict
name2number_map = Dict("one" => 1, "two" => 2)
name2number_map["three"] = 3
delete!(name2number_map, "three")
popped_value = pop!(name2number_map, "two")
name2number_map

A = ["one", "two", "three"]
B = [1, 2, 3]
name2number_map = Dict(zip(A, B))

#3.3.10 Symbol
sym = :love_and_peace

#3.3.11 Splat Operator
add_elements(a, b, c) = a + b + c
my_collection = [1, 2, 3]
add_elements(my_collection...)
add_elements(my_collection...) == add_elements(my_collection[1], my_collection[2], my_collection[3])
