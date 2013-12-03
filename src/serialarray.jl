type SerialArray{T,V} <: AbstractSeries
  collection::Array{SerialPair{T,V},1} # this prevents arrays of mixed types
  idxname::String
  valname::String
end

SerialArray(collection) = SerialArray(collection, "index", "values")

#################################
###### size, length, sort #######
#################################

length(sa::SerialArray) = length(sa.collection)
size(sa::SerialArray)   = size(sa.collection)
#Base.sort(sa::SerialArray)   = sort([s.index for s in sa.collection]) 
#sortindex(sa::SerialArray)   = sort([s.index for s in sa.collection]) 

# function Base.sort(sa::SerialArray)
#   sorted_index = sort([s.index for s in sa.collection])   # Array{T,1} where T is explicit
#   sorted_sa = SerialPair[]
#   for i in iteration
#   for j in iteration
#     if sorted_index[i] == sa[j].index 
#     push!(sorted_sa, sa[[j]) #assign that SerialPair
#     end
#   end
#   return sorted_sa
# end

# function Base.sort(sa::SerialArray)
#   sorted_index = sort([s.index for s in sa.collection])   # Array{T,1} where T is explicit
#   return sa[sorted_index] # see getindexMAGIC below
# end
#################################
###### getindex, setindex #######
#################################

getindex(sa::SerialArray, row::Int) = sa.collection[row]
#getindex(sa::SerialArray{T,V}, idx::{T}) = sa.collection[T(string(idx))]

#need to get index when index == value, instead of getting the row
getindex(sa::SerialArray, idx) = sa.collection[int(string(idx))]


# getindexMAGIC(sa::SerialArray, indexarray::Array)
#   magic code goes here
#   return sa[indexarray]
# end
#################################
###### show #####################
#################################

function show(io::IO, p::SerialArray)
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

########### # this is cut and paste from DataFrames.jl
########### # to print a DataFrame, find the max string length of each column
########### # then print the column names with an appropriate buffer
########### # then row-by-row print with an appropriate buffer

 _string(x) = sprint(showcompact, x)
 pad(item, num, dir) = dir == 'l' ? lpad(item, num) : rpad(item, num)
 maxShowLength(v::AbstractVector) = mapreduce(x->length(_string(x)), max, 0, v)

 function maxShowLength(sa::SerialArray)
     res = 0
     for i in 1:length(sa)
         if isdefined(sa.collection, i)
             res = max(res, length(_string(sa[i])))
         else
             res = max(res, length(Base.undef_ref_str))
         end
     end
     return res
 end
 maxShowLength(sa::AbstractSeries) = max(maxShowLength([sa]), length(sa.collection))
# colwidths(df::AbstractSeries) = [maxShowLength(df, col) for col=colnames(df)]
#  colwidths(row::sa.idxname) = [length(_string(row[i])) for i = 1:length(row)]

 
########### Base.showall(io::IO, df::AbstractSeries) = show(io, df, nrow(df))
########### function Base.show(io::IO, df::AbstractSeries)
###########     printed_width = sum(colwidths(df)) + length(ncol(df)) * 2 + 5
###########     if printed_width > Base.tty_cols()
###########         column_summary(io, df)
###########     else
###########         show(io, df, 20)
###########     end
########### end
########### 
########### function format_row(rows::Array{Any, 1}, colWidths, alignments::Array{Char,1})
###########     formatted_fields = [pad(rows[i], colWidths[i] + 2, alignments[i]) for i=[1:length(rows)]]
###########     return join(formatted_fields)
########### end
########### 
########### # Format a list of rows as a table.
########### function format_table(rows, alignments::Array{Char,1})
###########     colWidths = reduce(max, [colwidths(row) for row = rows])
###########     formatted_rows = [string(format_row(rows[i], colWidths, alignments), "\n") for i = [1:length(rows)]]
###########     return join(formatted_rows)
########### end
########### 
########### # Print a summary of the columns in the dataframe
########### function column_summary(io::IO, df::AbstractSeries)
###########     println(io, summary(df))
###########     println(io, "Columns:\n")
###########     summary_rows = [[col, sum(!isna(df[col])), " non-null values"] for col = colnames(df)]
###########     println(io, format_table(summary_rows, ['r', 'l', 'r']))
########### end
########### 
########### function Base.show(io::IO, df::AbstractSeries, Nmx::Integer)
###########     ## TODO use alignment() like print_matrix in show.jl.
###########     nrowz, ncolz = size(df)
###########     println(io, "$(nrowz)x$(ncolz) $(typeof(df)):")
###########     gr = get_groups(df)
###########     if length(gr) > 0
###########         #print(io, "Column groups: ")
###########         pretty_show(io, gr)
###########         println(io)
###########     end
###########     N = nrow(df)
###########     Nmx = Nmx   # maximum head and tail lengths
###########     if N <= 2Nmx
###########         rowrng = 1:min(2Nmx,N)
###########     else
###########         rowrng = [1:Nmx, N-Nmx+1:N]
###########     end
###########     # we don't have row names -- use indexes
###########     rowNames = [@sprintf("[%d,]", r) for r = rowrng]
###########     
###########     rownameWidth = maxShowLength(rowNames)
###########     
###########     # if we don't have columns names, use indexes
###########     # note that column names in R are obligatory
###########     if eltype(colnames(df)) == Nothing
###########         colNames = [@sprintf("[,%d]", c) for c = 1:ncol(df)]
###########     else
###########         colNames = colnames(df)
###########     end
###########     
###########     colWidths = [max(length(string(colNames[c])), maxShowLength(df[rowrng,c])) for c = 1:ncol(df)]
########### 
###########     header = string(" " ^ (rownameWidth+1),
###########                     join([lpad(string(colNames[i]), colWidths[i]+1, " ") for i = 1:ncol(df)], ""))
###########     println(io, header)
########### 
###########     for i = 1:length(rowrng)
###########         rowname = rpad(string(rowNames[i]), rownameWidth+1, " ")
###########         line = string(rowname,
###########                       join([lpad(_string(df[rowrng[i],c]), colWidths[c]+1, " ") for c = 1:ncol(df)], ""))
###########         println(io, line)
###########         if i == Nmx && N > 2Nmx
###########             println(io, "  :")
###########         end
###########     end
########### end

#################################
###### head, tail ###############
#################################

head{T<:SerialArray}(x::Array{T}, n::Int) = x[1:n]
head{T<:SerialArray}(x::T, n::Int) = x[1:n]
head{T<:SerialArray}(x::Array{T}) = head(x, 3)
first{T<:SerialArray}(x::Array{T}) = head(x, 1)

tail{T<:SerialArray}(x::Array{T}, n::Int) = x[length(x)-n+1:end]
tail{T<:SerialArray}(x::Array{T}) = tail(x, 3)
last{T<:SerialArray}(x::Array{T}) = tail(x, 1)
