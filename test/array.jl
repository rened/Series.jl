module TestSeriesArray
  
  using Base.Test
  using Series
  using Datetime
  
    op     = readseries(Pkg.dir("Series/test/data/spx.csv"))
    cl     = readseries(Pkg.dir("Series/test/data/spx.csv"), value=5)
    po     = flipud(op)
    poop   = sort(op)
    opnan  = lag(op)
    opno   = removenan(opnan)
    meanop = moving(op, mean, 10)
    uptoop = upto(op, sum)

    arr    = Array(op, cl[2:end])
    nonan  = removenan(arr)
    saadd  = op .+ cl
    sasub  = op .- cl
    samult = op .* cl
    sadiv  = op ./ cl
  
  # sorting
    @test poop[1].value == 92.06             
    @test poop[1].index == date(1970, 1, 2)  
  
  # indexing
    @test op[1].index       == date(1970, 1, 2) 
    @test op[1].value       == 92.06
    @test length(op[2:end]) == 506  # endof and length

  # construct Array of values
    @test size(arr)         == (507,2)
    @test sum(arr[2:end,2]) == 45901.85
    @test typeof(arr)       == Array{Float64, 2}
    @test isnan(arr[1,2])   == true

  # remove rows that have NaN
    @test size(nonan)       == (506,2)
    @test isnan(sum(nonan)) == false
    @test length(opno)     == 506
    @test isnan(sum([v.value for v in opno])) == false

  # broacast operator 
  # CAUTION: sorting NOT enforced
  # TODO: enforce sorting
  
    @test saadd[1].value   == 185.06
    @test_approx_eq sasub[1].value -0.9399999999999977   
    @test_approx_eq samult[1].value 8561.58  
    @test_approx_eq sadiv[1].value 0.9898924731182795

  # head and tail
    @test length(head(op))  == 1
    @test length(tail(op)) == 506
    @test head(op)[1].value == 92.06

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

  # moving
   @test isnan(meanop[9].value) == true
   @test_approx_eq meanop[10].value 92.43199999999999

  # upto
   @test uptoop[4].value == 371.34

  # bydate

  # from, to, collapse

end
