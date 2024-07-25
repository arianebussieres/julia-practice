using ModuleName

#3.5.1 Dates
using Dates
DateTime(1987, 9, 13, 21, 21) # year, month, day, hour, minute

my_birthday = Date("2002-03-05")
dayofweek(my_birthday)
dayname(my_birthday)
dayofweekofmonth(my_birthday)

today() - my_birthday

#3.5.2 Random Numbers
using Random: seed!
rand(3)
rand(1.0:10.0)
rand(2:2:20)
rand(2:2:20, 3)
rand((42, "Julia", 3.14))
rand([1, 2, 3])
rand(Dict(:one => 1, :two => 2))
rand(1.0:3.0, (2, 2))

randn((2, 2))

seed!(123)
rand(3)
my_seed = seed!(123)
rand(my_seed, 3)

#3.5.3 Downloads
using Downloads
url = "https://raw.githubusercontent.com/JuliaDataScience/JuliaDataScience/main/Project.toml"
my_file = Downloads.download(url, "C:/Users/abuss/github/julia-practice/data/download_practice") # tempfile() being created
readlines(my_file)[1:4]

#3.5.4 Project Management
 #julia>]
 #activate .
 #add DataFrames
 #rm 
