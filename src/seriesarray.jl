# methods to construct Array{SeriesPair{T,V},1} and operate on it

#################################
# Array method ##################
#################################

import Core.Array

function Array{T,V}(args::Array{SeriesPair{T,V},1}...) 
  key = typeof(args[1][1].index)[]
  
  # instead, create array of index values from args
  for arg in args
    for ar in arg
      push!(key, ar.index)
    end
  end

  # and sort without duplicates
  sortedkey = sortandremoveduplicates(key)

  arr = fill(NaN, 
             maximum([length(arg) for arg in args]), 
             # length(key) 
             length(args))

  sortedkey, args 
end


#################################
# sortandremoveduplicates #######
#################################

function sortandremoveduplicates(x::Array)
  sx = sort(x)
  res = [sx[1]]
  for i = 2:length(sx)
    if sx[i] > sx[i-1]
    push!(res, sx[i])
    end
  end
  res
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
