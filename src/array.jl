#################################
# SeriesArray constructor #######
#################################

function SeriesArray{T,V}(idx::Array{T,1}, val::Array{V,1})
  #res = SeriesPair[]
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
  allkey = typeof(args[1][1].index)[]
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
        k = key[t]
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

#################################
# broadcasting ##################
#################################

#for (op, broadcaster) in ([:+, :-, :*, :/], [:.+, :.-, :.*, :./])
#  @eval begin
#    function ($op){T,V}(sa1::Array{SeriesPair{T,V},1}, sa2::Array{SeriesPair{T,V},1}) 
############        res = SeriesPair{T,V}[]
############        for i in 1:length(sa1)
############          for j in 1:length(sa2)
############            if ($op)(sa1[i], sa2[j]) != nothing 
############              push!(res, ($op)(sa1[i], sa2[j]))
############            end
############          end
############        end
#res = ($op)(($broadcaster)(sa1, sa2))
#sort(res)
#    end # function
#  end # eval
#end # loop

#################################
# head, tail ####################
#################################

head{T,V}(x::Array{SeriesPair{T,V},1}) = [x[1]]
tail{T,V}(x::Array{SeriesPair{T,V},1}) = x[2:end]

#################################
# lag, lead #####################
#################################

function lag{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int) 
  displacedval = T[s.value for s in sa][1:length(sa) - 1]
  nanarray     = fill(NaN, n)
#  val          = vcat(nanarray, displacedval)
  val          = vcat(fill(NaN, n),  T[s.value for s in sa][1:length(sa) - 1])
  idx          = V[s.index for s in sa]
  SeriesArray(idx, val)
end

function lead{T,V}(sa::Array{SeriesPair{T,V},1}, n::Int) 
  displacedval = T[s.value for s in sa][n+1:end]
  nanarray     = fill(NaN, n)
  val          = vcat(displacedval, nanarray)
  idx          = V[s.index for s in sa]
  SeriesArray(idx, val)
end

lag{T,V}(sa::Array{SeriesPair{T,V},1}) = lag(sa, 1)
lead{T,V}(sa::Array{SeriesPair{T,V},1}) = lead(sa, 1)

#################################
# percentchange #################
#################################

function percentchange{T,V}(sa::Array{SeriesPair{T,V},1}; method="simple") 

  logval    = vcat(NaN, (T[s.value for s in sa] |> log |> diff))
  simpleval = vcat(NaN, (T[s.value for s in sa] |> log |> diff |> expm1))
  idx       = V[s.index for s in sa]
  if method == "simple" 
    SeriesArray(idx, simpleval)
  elseif method == "log" 
    SeriesArray(idx, logval)
  else 
    throw("only simple and log methods supported")
  end
end
