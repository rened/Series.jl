using MarketData

fails = 0
  
@context "boolean values are evaluated needs rewrite"

    ba = SeriesArray([1:3], trues(3))
    jtest( sum(value(ba)) == 3)

@context "arrays with names needs rewrite"

    na = SeriesArray([1:3], [2:4], "test")
    jtest(na[1].name == "test", 
          na[2].name == "test", 
          na[3].name == "test")

@context "sorting needs rewrite"

    jtest( op[1].value == 92.06,             
           op[1].index == firstday)
  
@context "indexing needs rewrite"

    jtest(op[1].index       == date(1970, 1, 2),  
          op[1].value       == 92.06, 
          length(op[2:end]) == 506)  

@context "construct Array of values needs rewrite"

    arr    = Array(op, cl[2:end])
    jtest(size(arr)         == (507,2),
          sum(arr[2:end,2]) == 45901.85,
          typeof(arr)       == Array{Float64, 2},
          isnan(arr[1,2])   == true)

@context "remove rows that have NaN needs rewrite"

    nonan  = removenan(arr)
    opnan  = lag(op)
    opno   = removenan(opnan)

    jtest( size(nonan)       == (506,2), 
           isnan(sum(nonan)) == false, 
           length(opno)     == 506, 
           isnan(sum([v.value for v in opno])) == false)

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

@context "head and tail needs rewrite"

    jtest(length(head(op))  == 1, 
          length(tail(op)) == 506, 
          head(op)[1].value == 92.06)

@context "lag and lead on sorted array though it would work on unsorted ones too"
# @context "also needs total rewrite"

    jtest(isnan(lag(op)[1].value) == true, 
          lag(op)[2].value        == 92.06,
          lag(op,2)[3].value      == 92.06,
          lag(op)[1].index        == date(1970, 1, 2),
          lead(op)[1].value       == 93.0, 
          lead(op)[1].index       == date(1970, 1, 2))

@context "percentchange needs rewrite"

    jtest(isnan(percentchange(op)[1].value)      == true, 
          percentchange(op)[2].value == 0.010210732131218946, 
          percentchange(op, method="log")[2].value == 0.010158954764160733)

@context "moving, upto needs rewrite"  

    meanop   = moving(op, mean, 10)
    uptoop   = upto(op, sum)

    jtest( isnan(meanop[9].value) == true, 
           op[10].value  == 92.43199999999999, 
           uptoop[4].value == 371.34)

@context "bydate needs rewrite"

    yrop  = byyear(op, 1980) 
    mthop = bymonth(op, 2) 
    dayop = byday(op, 2) 
    dowop = bydow(op, 5) 
    doyop = bydoy(op, 4) 

    jtest( yrop[length(yrop)].index   == date(1970,12,31),  
           mthop[length(mthop)].index == date(1971,2,26),   
           dayop[length(dayop)].index == date(1971,12,2),   
           dowop[length(dowop)].index == date(1971,12,31),  
           doyop[length(doyop)].index == date(1971,1,4))

@context "from, to, collapse needs rewrite"

    opto     = to(op,1980,12,31) 
    opfrom   = from(op,1981,1,4) 
    opweekly = collapse(op, first)
    clmnthly = collapse(cl, last, period=month)

    jtest( opto[length(opto)].index == date(1970, 12, 31), 
           opfrom[1].index          == date(1971, 1, 4),  
           opweekly[2].value        == 93.00, 
           clmnthly[1].value        == 85.02,                
           length(clmnthly)         == 24)              
