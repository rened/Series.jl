abstract AbstractSeries

immutable SeriesPair{T, V} <: AbstractSeries
  index::T
  value::V
end

#################################
###### show #####################
#################################

function show(io::IO, p::SeriesPair)
   #print(io, p.index, "  |  ", join([@sprintf("%.4f",x) for x in p.value]," "))
   print(io, p.index, "  ",  p.value)
end
