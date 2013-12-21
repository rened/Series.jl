module DataSeries

using Datetime

import Base.show,
       Base.isless

export SeriesPair, 
       Series, 
       readseries, 
       removenan, 
       head, tail, first, last,
       @dataseries
  
abstract AbstractSeriesPair

immutable SeriesPair{T, V} <: AbstractSeriesPair
  index::T
  value::V
  name::String
end

SeriesPair{T,V}(x::T,y::V) = SeriesPair{T,V}(x::T,y::V,"value")

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
   println("     ",  p.name)
   print(io, p.index, "  ",  p.value)
end

#################################
###### include ##################
#################################

  include("seriesarray.jl")
  include("io.jl")
  include("../test/testmacro.jl")
end
