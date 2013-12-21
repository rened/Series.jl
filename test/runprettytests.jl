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

#function pretty(file, x)
function pretty(x)
  #print_with_color(:yellow, "$file   ")
  print_with_color(:yellow, "hi:   ")
  dots(x)
  println("")
end

for test in tests
    include(test)
    pretty(testarray)
end
