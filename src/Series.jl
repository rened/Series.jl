module Series

using Datetime

import Base.show,
       Base.isless

export SeriesPair, 
       SeriesArray, 
       +, -, *, /, 
       .+, .-, .*, ./, 
       readseries, 
       removenan, 
       head, tail, 
       index, value, name, 
       lag, lead, 
       percentchange, 
       moving, upto,  
       byyear, bymonth, byday, bydow, bydoy, 
       from, to, collapse, 
       @series, 
       @prettyseries
  
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
   print(io, p.index, "  ",  p.value)
end

#################################
###### +, -, *, / ###############
#################################

for op in [:+, :-, :*, :/, :.+, :.-, :.*, :./]
  @eval begin
    function ($op){T,V}(sp1::SeriesPair{T,V}, sp2::SeriesPair{T,V})
      matches = false 
      if sp1.index == sp2.index
         matches = true
         res = SeriesPair(sp1.index, ($op)(sp1.value, sp2.value))
      end
      matches == true? res: nothing  # nothing is indignity enough rather than an error
    end
  end
end

#################################
###### include ##################
#################################

  include("array.jl")
  include("io.jl")
  include("../test/testmacro.jl")
  include("../test/pretty/prettytestmacro.jl")
end
