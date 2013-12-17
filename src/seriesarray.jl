# methods to construct Array{SeriesPair{T,V},1} and operate on it

#################################
# Array method ##################
#################################

import Core.Array

function Array{T,V}(args::Array{SeriesPair{T,V},1}...) 
  key = typeof(args[1][1].index)[]
  
   # instead, create array of index values from args
       # for arg in args
       # print([a.index for a in arg])
       # end
   # and sort without duplicates

  arr = fill(NaN, 
             maximum([length(arg) for arg in args]), 
             # length(key) 
             length(args))

  key, args 
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
