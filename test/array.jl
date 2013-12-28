module TestSeriesArray
  
  using Base.Test
  using Series
  using Datetime
  
  # arrays with Datetime index
    op = readseries(Pkg.dir("Series/test/data/spx.csv"))
    cl = readseries(Pkg.dir("Series/test/data/spx.csv"), value=5)
  
  # arrays with boolean values
    ba = SeriesArray([1:3], trues(3))

    @test sum(value(ba)) == 3

  # arrays with names
    na = SeriesArray([1:3], [2:4], "test")
 
    @test na[1].name == "test"
    @test na[2].name == "test"
    @test na[3].name == "test"

  # sorting
    po       = flipud(op)
    sopo     = sort(op)

    @test sopo[1].value == 92.06             
    @test sopo[1].index == date(1970, 1, 2)  
  
  # indexing
    @test op[1].index       == date(1970, 1, 2) 
    @test op[1].value       == 92.06
    @test length(op[2:end]) == 506  # endof and length

  # construct Array of values
    arr    = Array(op, cl[2:end])

    @test size(arr)         == (507,2)
    @test sum(arr[2:end,2]) == 45901.85
    @test typeof(arr)       == Array{Float64, 2}
    @test isnan(arr[1,2])   == true

  # remove rows that have NaN
    nonan  = removenan(arr)
    opnan  = lag(op)
    opno   = removenan(opnan)

    @test size(nonan)       == (506,2)
    @test isnan(sum(nonan)) == false
    @test length(opno)     == 506
    @test isnan(sum([v.value for v in opno])) == false

  # broacast operator 
  # CAUTION: sorting NOT enforced
  # TODO: enforce sorting
  
    saadd  = op .+ cl
    sasub  = op .- cl
    samult = op .* cl
    sadiv  = op ./ cl

    @test saadd[1].value   == 185.06
    @test_approx_eq sasub[1].value -0.9399999999999977   
    @test_approx_eq samult[1].value 8561.58  
    @test_approx_eq sadiv[1].value 0.9898924731182795

  # head and tail
    @test length(head(op))  == 1
    @test length(tail(op)) == 506
    @test head(op)[1].value == 92.06

  # index and value and name
    @test value(op)[1] == 92.06
    @test index(op)[1] == date(1970,1,2)
    @test name(na)[1] == name(na)[2] == name(na)[3]

  # lag and lead on sorted array (though it would work on unsorted ones too)
    @test isnan(lag(op)[1].value) == true
    @test lag(op)[2].value        == 92.06
    @test lag(op,2)[3].value      == 92.06
    @test lag(op)[1].index        == date(1970, 1, 2)
    @test lead(op)[1].value       == 93.0
    @test lead(op)[1].index       == date(1970, 1, 2)

  # percentchange
    @test isnan(percentchange(op)[1].value)      == true
    @test_approx_eq  percentchange(op)[2].value 0.010210732131218946
    @test_approx_eq percentchange(op, method="log")[2].value 0.010158954764160733

  # moving, upto  
    meanop   = moving(op, mean, 10)
    uptoop   = upto(op, sum)

    @test isnan(meanop[9].value) == true
    @test_approx_eq meanop[10].value 92.43199999999999
    @test uptoop[4].value == 371.34

  # bydate
    yrop  = byyear(op, 1970) #1970s
    mthop = bymonth(op, 2) # Februarys
    dayop = byday(op, 2) # where the day is #2
    dowop = bydow(op, 5) # fifth day of week or Fridays
    doyop = bydoy(op, 4) # fourth day of year

    @test yrop[length(yrop)].index   == date(1970,12,31) # 1970s
    @test mthop[length(mthop)].index == date(1971,2,26)  # Februarys
    @test dayop[length(dayop)].index == date(1971,12,2)  # day # is 2
    @test dowop[length(dowop)].index == date(1971,12,31) # Fridays
    @test doyop[length(doyop)].index == date(1971,1,4)   # fourth day of year

  # from, to, collapse
    opto     = to(op,1970,12,31) # includes row in series
    opfrom   = from(op,1971,1,4) # includes row in series
    opweekly = collapse(op, first)
    clmnthly = collapse(cl, last, period=month)

    @test opto[length(opto)].index == date(1970, 12, 31) 
    @test opfrom[1].index          == date(1971, 1, 4) 
    @test opweekly[2].value        == 93.00
    @test clmnthly[1].value        == 85.02               
    @test length(clmnthly)         == 24             
end
