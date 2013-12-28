#################################
# index, value, name ############
#################################

index{T,V}(sa::Array{SeriesPair{T,V},1}) = T[s.index for s in sa]
value{T,V}(sa::Array{SeriesPair{T,V},1}) = V[s.value for s in sa]
name{T,V}(sa::Array{SeriesPair{T,V},1})  = String[s.name for s in sa]

#################################
# istrue ########################
#################################

function istrue{T,Bool}(sa::Array{SeriesPair{T,Bool},1})
  res = SeriesPair{T,Bool}[]
  for i in 1:length(sa)
    if sa[i].value
      push!(res, sa[i])
    end
  end
  res
end
                 
