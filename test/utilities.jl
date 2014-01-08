using MarketData

fails = 0
 
@context "value, index and name"
jtest(value(op)[1] == 105.76, 
      index(op)[1] == firstday, 
      name(op)[1] == name(op)[2] == name(op)[3])
fails += fails

@context "istrue"
    bt = SeriesArray([1:3], trues(3))
    ba = push!(bt, SeriesPair(4, false))
jtest(length(istrue(ba)) == 3)
fails += fails

@context "when"
jtest(when(op, [firstday, secondday, tenthday])[1].value == 105.76, 
      when(op, [firstday, secondday, tenthday])[2].value == 105.22,
      when(op, [firstday, secondday, tenthday])[3].value == 111.14,
      when(op, [firstday, secondday, tenthday])[1].index == firstday,
      when(op, [firstday, secondday, tenthday])[2].index == secondday,
      when(op, [firstday, secondday, tenthday])[3].index == tenthday)
fails += fails
