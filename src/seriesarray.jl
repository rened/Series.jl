# methods to construct Array{SeriesPair{T,V},1} and operate on it

#################################
# Array method ##################
#################################

import Core.Array

function Array{T,V}(args::Array{SeriesPair{T,V},1}...) 

#  arr = fill(NaN, maximum(size,1) ,length(args))
  arr = fill(NaN, 2 ,length(args))
  
# find which arg has the lowest and highest index value



#  for arg in args
#    if arg[i].index == arg[1].index
#  push!(arr, 
#   print(ar.index)
# end
# end
arr
end

#################################
# head, tail, first, last  ######
#################################

head{T,V}(x::Array{SeriesPair{T,V},1}, n::Int) = x[[1:n]]
head{T,V}(x::Array{SeriesPair{T,V},1}) = head(x, 3)

first{T,V}(x::Array{SeriesPair{T,V},1}) = head(x, 1)

tail{T,V}(x::Array{SeriesPair{T,V},1}, n::Int) = x[length(x)-n+1:end]
tail{T,V}(x::Array{SeriesPair{T,V},1}) = tail(x, 3)

last{T,V}(x::Array{SeriesPair{T,V},1}) = tail(x, 1)
