using MarketData

fails = 0
 
@context "names"

jtest(value(op)[1] == 92.06, 
          index(op)[1] == date(1970,1,2), 
          name(op)[1] == name(op)[2] == name(op)[3])

@context "istrue"

    bt = SeriesArray([1:3], trues(3))
    ba = push!(bt, SeriesPair(4, false))

jtest(length(istrue(ba)) == 3)

@context "when"

    dates = [date(1980,12,1), date(1980,12,2), date(1980,12,3)]

jtest(when(op, dates)[2].value == 87.47)
