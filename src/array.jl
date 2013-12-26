#################################
# SeriesArray constructor #######
#################################

function SeriesArray{T,V}(idx::Array{T,1}, val::Array{V,1})
  res = SeriesPair{T,V}[]
  for i = 1:size(idx,1)
    x = SeriesPair(idx[i], val[i])
    push!(res, x)
  end
  res
end

#################################
# Array method ##################
#################################

import Core.Array

function Array{T,V}(args::Array{SeriesPair{T,V},1}...) 
  
  # create array of index values from args
  allkey = T[]
  for arg in args
    for ar in arg
      push!(allkey, ar.index)
    end
  end

  # and sort without duplicates
  key = sortandremoveduplicates(allkey)

  # match each arg in args with key 
  arr = fill(NaN, length(key), length(args))
    for i in 1:length(args)
      for j = 1:length(args[i])
        t = args[i][j].index .== key
        k = findfirst(t)
        arr[k,i] = args[i][j].value 
      end
    end
  arr
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
# removenan #####################
#################################

function removenan(x::Array)
  idx= Int[]
    for i in 1:size(x, 1)
      if ~isnan(sum(x[i,:])) # detect row doens't have an NaN
        push!(idx, i)    # keep it
      end
    end
  x[idx,:] 
end

function removenan{T,V}(sa::Array{SeriesPair{T,V},1})
  s = SeriesPair[] # there is no method isnan for Float64 oddly, so this trick is in place
    for i in 1:length(sa)
      if ~isnan(sa[i].value) # detect row doens't have an NaN
        push!(s, sa[i])    # keep it
      end
    end
  SeriesArray(T[t.index for t in s], V[v.value for v in s])  # make the types explicit
end

#################################
# broadcasting ##################
#################################


#################################
# head, tail ####################
#################################

head{T,V}(x::Array{SeriesPair{T,V},1}) = [x[1]]
tail{T,V}(x::Array{SeriesPair{T,V},1}) = x[2:end]

#################################
# lag, lead #####################
#################################

function lag{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int) 
  idx          = T[s.index for s in sa]
  displacedval = V[s.value for s in sa][1:length(sa) - n]
  nanarray     = fill(NaN, n)
  val          = vcat(nanarray, displacedval)
  SeriesArray(idx, val)
end

function lead{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int) 
  idx          = T[s.index for s in sa]
  displacedval = V[s.value for s in sa][n+1:end]
  nanarray     = fill(NaN, n)
  val          = vcat(displacedval, nanarray)
  SeriesArray(idx, val)
end

lag{T,V}(sa::Array{SeriesPair{T,V},1}) = lag(sa, 1)
lead{T,V}(sa::Array{SeriesPair{T,V},1}) = lead(sa, 1)

#################################
# percentchange #################
#################################

function percentchange{T,V}(sa::Array{SeriesPair{T,V},1}; method="simple") 

  logval    = vcat(NaN, (V[s.value for s in sa] |> log |> diff))
  simpleval = vcat(NaN, (V[s.value for s in sa] |> log |> diff |> expm1))
  idx       = T[s.index for s in sa]
  if method == "simple" 
    SeriesArray(idx, simpleval)
  elseif method == "log" 
    SeriesArray(idx, logval)
  else 
    throw("only simple and log methods supported")
  end
end

#################################
# moving ########################
#################################

function moving{T,V}(sa::Array{SeriesPair{T,V},1}, f::Function, window::Int) 

  idx      = T[s.index for s in sa]
  nanarray = fill(NaN, window-1)
  valarray = V[]
  for i=1:length(sa)-(window-1)
    push!(valarray, f([s.value for s in sa][i:i+(window-1)])) 
  end
  val = vcat(nanarray, valarray)
  SeriesArray(idx, val)
end

#################################
# upto ##########################
#################################

function upto{T,V}(sa::Array{SeriesPair{T,V},1}, f::Function) 

  idx = T[s.index for s in sa]
  val = V[]
  for i=1:length(sa)
    push!(val, f([s.value for s in sa][1:i])) 
  end
  SeriesArray(idx, val)
end

#################################
# bydate ########################
#################################

#################################
# from, to, collapse ############
#################################
