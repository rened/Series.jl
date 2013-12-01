using Datetime

module A

using Datetime

import Base.show

export Series, 
       head,
       tail,
       first, 
       last

abstract AbstractSeries

type Series <: AbstractSeries
  index
  values
  nas::BitArray

  Series(x,y) = new(x,y,falses(length(x)))
end

#################################
###### show #####################
#################################

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

#################################
###### head, tail ###############
#################################

head{T<:Series}(x::Array{T}, n::Int) = x[1:n]
head{T<:Series}(x::Array{T}) = head(x, 3)
first{T<:Series}(x::Array{T}) = head(x, 1)

tail{T<:Series}(x::Array{T}, n::Int) = x[length(x)-n+1:end]
tail{T<:Series}(x::Array{T}) = tail(x, 3)
last{T<:Series}(x::Array{T}) = tail(x, 1)
 


end # of module
