module A

import Base.show

export Series, 
       head,
       tail,
       first, 
       last

abstract AbstractSeries

immutable Series{T, V} <: AbstractSeries
  index::T
  value::V

#  if length(x == y)
#  Series(x,y) = new(x,y)
#  else
#  "Must be the same length"
#  end
#  end
end

type DataSeries{T,V} <: AbstractSeries
  x::Array{Series{T,V},1}
end

#################################
###### show #####################
#################################

function show(io::IO, p::Series)
   #print(io, p.index, "  |  ", join([@sprintf("%.4f",x) for x in p.value]," "))
   print(io, p.index, " | ",  p.value)

end

# function show(io::IO, p::Series)
#   n = length(p.index)
#     if n < 7
#   for i = 1:n
#       println(io, "  ", p.index[i], "  ", p.values[i])
#     end
#   end
#     if n > 7
#     for i = 1:3
#     println(io, "  ", p.index[i], "  ", p.values[i])
#     end
#     println("  ...")
#     println("  ... extra exciting stuff is here!")
#     println("  ...")
#     for i = n-2:n
#     println(io, "  ", p.index[i], "  ", p.values[i])
#     end
#   end
# end

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
