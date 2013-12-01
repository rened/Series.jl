module A

import Base.show

export Series

type Series
  index::Array
  values::Array
  nas::BitArray

  Series(x,y) = new(x,y,falses(length(x)))
end

######## show

function show(io::IO, p::Series)
  n = length(p.index)
    if n < 7
  for i = 1:n
      println(io, "  ", p.index[i], "  ", p.values[i])
    end
  end
    if n > 7
    for i = 1:3
    println(io, "  ", p.index[i], "  ", p.values[i])
    end
    println("  ...")
    println("  ... extra exciting stuff is here!")
    println("  ...")
    for i = n-2:n
    println(io, "  ", p.index[i], "  ", p.values[i])
    end
  end
end



end # of module
