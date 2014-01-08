using MarketData

fails = 0
  
@context "boolean values are evaluated needs rewrite"
   ba = SeriesArray([1:3], trues(3))
  jtest( sum(value(ba)) == 3)
fails += fails

@context "arrays with names needs rewrite"
  na = SeriesArray([1:3], [2:4], "test")
  jtest(na[1].name == "test", 
        na[2].name == "test", 
        na[3].name == "test")
fails += fails

@context "sorting needs rewrite"
  jtest( op[1].value == 92.06,             
         op[1].index == firstday)
fails += fails
  
@context "indexing needs rewrite"
  jtest(op[1].index       == date(1970, 1, 2),  
        op[1].value       == 92.06, 
        length(op[2:end]) == 506)  
fails += fails

@context "construct Array of values needs rewrite"
  arr    = Array(op, cl[2:end])
  jtest(size(arr)         == (507,2),
        sum(arr[2:end,2]) == 45901.85,
        typeof(arr)       == Array{Float64, 2},
        isnan(arr[1,2])   == true)
fails += fails

@context "remove rows that have NaN needs rewrite"
  nonan  = removenan(arr)
  opnan  = lag(op)
  opno   = removenan(opnan)
  jtest( size(nonan)       == (506,2), 
         isnan(sum(nonan)) == false, 
         length(opno)     == 506, 
         isnan(sum([v.value for v in opno])) == false)
fails += fails

@context "broadcast operator needs rewrite" 
# @context "CAUTION: sorting NOT enforced"
# @context "TODO: enforce sorting"
  saadd  = op .+ cl
  sasub  = op .- cl
  samult = op .* cl
  sadiv  = op ./ cl
  jtest(saadd[1].value   == 185.06, 
        sasub[1].value  ==  -0.9399999999999977, 
        samult[1].value ==  8561.58,   
        sadiv[1].value  ==  0.9898924731182795)
fails += fails

@context "head and tail needs rewrite"
  jtest(length(head(op))  == 1, 
        length(tail(op)) == 506, 
        head(op)[1].value == 92.06)
fails += fails

@context "lag and lead on sorted array though it would work on unsorted ones too"
@context "also needs total rewrite"
  jtest(isnan(lag(op)[1].value) == true, 
        lag(op)[2].value        == 92.06,
        lag(op,2)[3].value      == 92.06,
        lag(op)[1].index        == date(1970, 1, 2),
        lead(op)[1].value       == 93.0, 
        lead(op)[1].index       == date(1970, 1, 2))
fails += fails
