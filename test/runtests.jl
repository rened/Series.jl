using Base.Test
using DataSeries

tests = ["io.jl",
         "seriespair.jl",
         "seriesarray.jl"]

print_with_color(:cyan, "Running tests: ") 
println("")

for test in tests
    suite = test[1:end-3]
    print_with_color(:magenta, "**   ") 
    print_with_color(:blue, "$suite ") 
    println("")
    include(test)
end
