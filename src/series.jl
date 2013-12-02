module A

import Base.show

export Series, 
       DataSeries,
       head,
       tail,
       first, 
       last

abstract AbstractSeries

immutable Series{T, V} <: AbstractSeries
  index::T
  value::V
end

type DataSeries{T,V} <: AbstractSeries
  collection::Array{Series{T,V},1}
end

#################################
###### show #####################
#################################

function show(io::IO, p::Series)
   #print(io, p.index, "  |  ", join([@sprintf("%.4f",x) for x in p.value]," "))
   print(io, p.index, " | ",  p.value)

end

function show(io::IO, p::DataSeries)
  n = length(p.collection)
    if n < 7
  for i = 1:n
      println(io, p.collection[i])
    end
  end
    if n > 7
    for i = 1:3
    println(io, p.collection[i])
    end
    println("  ...")
    println("  ... extra stuff is here!")
    println("  ...")
    for i = n-2:n
    println(io, p.collection[i])
    end
  end
end

#################################
###### head, tail ###############
#################################

head{T<:Series}(x::Array{T}, n::Int) = x[1:n]
head{T<:DataSeries}(x::T, n::Int) = x[1:n]
head{T<:Series}(x::Array{T}) = head(x, 3)
first{T<:Series}(x::Array{T}) = head(x, 1)

tail{T<:Series}(x::Array{T}, n::Int) = x[length(x)-n+1:end]
tail{T<:Series}(x::Array{T}) = tail(x, 3)
last{T<:Series}(x::Array{T}) = tail(x, 1)
 


end # of module
