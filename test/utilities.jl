
    @test value(op)[1] == 92.06
    @test index(op)[1] == date(1970,1,2)
    @test name(op)[1] == name(op)[2] == name(op)[3]

    # istrue
    bt = SeriesArray([1:3], trues(3))
    ba = push!(bt, SeriesPair(4, false))

    @test length(istrue(ba)) == 3

    # when
    dates = [date(1970,12,1), date(1970,12,2), date(1970,12,3)]

    @test when(op, dates)[2].value == 87.47
