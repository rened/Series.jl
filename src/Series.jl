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
       lag, lead, 
       percentchange, 
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
   #print(io, p.index, "  |  ", join([@sprintf("%.4f",x) for x in p.value]," "))
   #spc = repeat(" ", length(sprint(showcompact, p.index)) + 2)
   #println(spc,  p.name)
   print(io, p.index, "  ",  p.value)
end

function show(io::IO, sa::Array{SeriesPair, 1})
  print(io, "foo")
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
