abstract AbstractSeriesPair

immutable SeriesPair{T, V} <: AbstractSeriesPair
  index::T
  value::V

end

#################################
###### isless ###################
#################################

function isless(sp1::SeriesPair, sp2::SeriesPair)
  a, b = sp1.index, sp2.index
  if !isequal(a, b)
   return isless(a, b)
  end
end

#################################
###### show #####################
#################################

function show(io::IO, p::SeriesPair)
   #print(io, p.index, "  |  ", join([@sprintf("%.4f",x) for x in p.value]," "))
   print(io, p.index, "  ",  p.value)
end
