using MarketData

fails = 0

@context "percentchange"
jtest(isnan(percentchange(op)[1].value)        == true, 
      percentchange(op)[2].value               == -0.005105900151286568,
      percentchange(op, method="log")[2].value == -0.005118979800715628)
fails += fails

@context "moving, upto"  
jtest(isnan(moving(op, mean, 10)[9].value) == true, 
      moving(op, mean, 10)[10].value       == 108.36399999999999,
      upto(op, sum)[4].value               == 424.31)
fails += fails

@context "bydate"
jtest(byyear(op, 1980)[1].index == firstday,  
      bymonth(op, 2)[1].index   == secondmonth,   
      byday(op, 16)[1].index    == tenthday,   
      bydow(op, 5)[1].index     == secondday,  
      bydoy(op, 4)[1].index     == secondday)
fails += fails

@context "from, to and collapse"
jtest(to(op, 1980,12,31)[end].index            == lastday - years(1), 
      from(op,1981,1,2)[1].index               == firstday + days(365),  
      collapse(op, maximum)[2].value           == 109.89,
      length(collapse(cl, last, period=month)) == 24)              
fails += fails
