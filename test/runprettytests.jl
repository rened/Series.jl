tests = ["prettyio.jl",
         "prettyseriespair.jl",
         "prettyseriesarray.jl"]

function dots(assertions)
  for assert in 1:length(assertions)
    assertions[assert]?
    print_with_color(:green, "."):
    print_with_color(:red, ".")
  end
end

function chopthree(c)
  for i in 1:3
    c = chop(c)
  end
  c
end

for test in tests
    include(test)
    suite = chopthree(test)
    print_with_color(:yellow, "$suite:   ") 
    dots(testarray)
    println("")
end
