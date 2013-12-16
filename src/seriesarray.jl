abstract AbstractSeriesArray

type SeriesArray{T,V} <: AbstractSeriesArray
  collection::Array{SeriesPair{T,V},1} # this prevents arrays of mixed types

                                                 #2 type SeriesArray{T<:SeriesPair} <: AbstractArray
                                                 #3 type SeriesArray{T<:SeriesPair{{Q,R},1}} <: AbstractArray
                                                 #2  collection::Array{T,1}
                                                 #3  collection::Array{T{{Q,R},1}


  idxname::String
  valname::String
end

SeriesArray{T,V}(c::Array{SeriesPair{T,V},1}) = SeriesArray{T,V}(c::Array{SeriesPair{T,V},1}, "index", "values")
#SeriesArray(collection) = SeriesArray(collection, "index", "values")



#################################
###### size, length #############
#################################

length(sa::SeriesArray) = length(sa.collection)
size(sa::SeriesArray)   = size(sa.collection)

#################################
## sort, sortindex, insert_pair #
#######  getindexMAGIC ##########
#################################

sortindex(sa::SeriesArray)   = sort([s.index for s in sa.collection]) 

function Base.sort(sa::SeriesArray)
  #sorted_index = sort([s.index for s in sa.collection])   # Array{T,1} where T is explicit
  sorted_index = sortindex(sa)
  #return getindexMAGIC(sa, sorted_index) # see getindexMAGIC below
  sa[sorted_index]
end

function getindexMAGIC(sa::SeriesArray, indexarray::Array)
  # types must match, though this might be caught in method signature
  if typeof(sa.collection[1].index)  !== typeof(indexarray[1])
    msg = "Need types to match between SeriesArray and the indexarray argument"
    throw(ArgumentError(msg))
  end
  
  # capture typeof SeriesPair
    spT = typeof(sa.collection[1].index)
    spV = typeof(sa.collection[1].value)

  # double loop solution
  unsatisfactory_container = SeriesPair{spT, spV}[]
#  res = SeriesArray(SeriesPair{spT, spV}[]) #doesn't work 
  for i in 1:length(indexarray)
    for j in 1:length(sa)
      if indexarray[i] == sa[j].index
        push!(unsatisfactory_container, sa[j])
        #push!(res, sa[j])
      end
     end
   end
  better_container = SeriesArray(unsatisfactory_container)
  #res
end

function insertpair(sa::SeriesArray, pr::SeriesPair)
  # check for types matching
 
  #capture types
  spT = typeof(sa.collection[1].index)
  spV = typeof(sa.collection[1].value)
 
  container = SeriesPair{spT, spV}[]
 
  for i in 1:length(sa)
  push!(container, sa[i])
  end
 
  push!(container, pr)
 
  #res = SeriesArray(container)
  sa = SeriesArray(container)
end

#################################
###### getindex, setindex #######
#################################

# sa[1:3] is the first 3 rows
getindex(sa::SeriesArray, row::Int) = sa.collection[row]

# sa[array_of_index_values] or sa[[1,2,3]] to get sa where index == 1,2,3
getindex(sa::SeriesArray, idx::Array) = getindexMAGIC(sa, idx) 


# sa[length(sa)+1] so far only
setindex!(sa::SeriesArray, pr::SeriesPair, pos::Int64) = insertpair(sa, pr) 

#################################
###### show #####################
#################################

function show(io::IO, p::SeriesArray)
  n = length(p.collection)
    if n < 7
      println(io, p.idxname,"  ", p.valname)
  for i = 1:n
      println(io, p.collection[i].index,"  ", p.collection[i].value)
    end
  end
    if n > 7
    for i = 1:3
    println(io, p.collection[i])
    end
    println("  ...")
    println("  ... extra stuff is here!")
    println("  ...")
    for i = n-2:n
    println(io, p.collection[i])
    end
  end
end


#################################
###### head, tail ###############
#################################

head(x::SeriesArray, n::Int) = x[[1:n]]
head(x::SeriesArray) = head(x, 3)
first(x::SeriesArray) = head(x, 1)

# need method endof
#tail(x::SeriesArray, n::Int) = x[length(x)-n+1:end]
#tail(x::SeriesArray) = tail(x, 3)
#last(x::SeriesArray) = tail(x, 1)
