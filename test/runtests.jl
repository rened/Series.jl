using Base.Test
using Series

tests = ["array.jl",
         "io.jl",
         "series.jl",
         "utilities.jl"]
         

print_with_color(:cyan, "Running tests: ") 
println("")

for test in tests
    suite = test[1:end-3]
    print_with_color(:magenta, "**   ") 
    print_with_color(:blue, "$suite ") 
    println("")
    include(test)
end
