using MarketData

fails = 0
  
@context "boolean values are evaluated"
ba = SeriesArray([1:3], trues(3))
f=jtest( sum(value(ba)) == 3)
fails += f

@context "arrays with names"
na = SeriesArray([1:3], [2:4], "test")
f=jtest(na[1].name == "test", 
        na[2].name == "test", 
        na[3].name == "test")
fails += f

@context "readseries sorts"
f=jtest( op[1].value == 105.76,             
         op[1].index == firstday)
fails += f
  
@context "indexing"
f=jtest(op[1].index       == firstday,
        op[1].value       == 105.76, 
        length(op[2:end]) == 504)  
fails += f

@context "construct Array of values"
arr    = Array(op, cl[2:end])
f=jtest(size(arr)                    == (505,2),
        round(sum(arr[2:end,2]), 2)  == 62216.27,
        typeof(arr)                  == Array{Float64, 2},
        isnan(arr[1,2])              == true)
fails += f

@context "remove rows that have NaN"
f=jtest( size(removenan(arr))                   == (504,2), 
         isnan(sum(removenan(arr)))             == false, 
         length(lag(op))                        == 505, 
         isnan(sum([v.value for v in lag(op)])) == true)
fails += f

@context "broadcast operator needs rewrite" 
# "CAUTION: sorting NOT enforced"
# "TODO: enforce sorting"
f=jtest((op .+ cl)[1].value == 210.98000000000002, 
        (op .- cl)[1].value ==  0.5400000000000063, 
        (op .* cl)[1].value ==  11128.067200000001,   
        (op ./ cl)[1].value ==  1.0051321041627068)
fails += f

@context "head and tail"
f=jtest(length(head(op))  == 1, 
        length(tail(op)) == 504, 
        head(op)[1].value == 105.76)
fails += f

@context "lag and lead sorted array"
f=jtest(isnan(lag(op)[1].value) == true, 
        lag(op)[2].value        == 105.76,
        lag(op,2)[3].value      == 105.76,
        lag(op)[1].index        == firstday,
        lead(op)[1].value       == 105.22, 
        lead(op)[1].index       == firstday)
fails += f
