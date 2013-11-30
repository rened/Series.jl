module TestNAs
	using Base.Test
	using DataSeries

	dv = DataSeries([1, 2, 3], bitpack([false, false, false]))

	dv = DataSeries([1, 2, 3], [false, false, false])

	failNA(dv)
	removeNA(dv)
	replaceNA(dv, 3)
	for v in each_failNA(dv)
		println(v)
	end
	for v in each_removeNA(dv)
		println(v)
	end
	for v in each_replaceNA(dv, 3)
		println(v)
	end

	dv[1] = NA

	failNA(dv)
	removeNA(dv)
	replaceNA(dv, 3)
	for v in each_failNA(dv)
		println(v)
	end
	for v in each_removeNA(dv)
		println(v)
	end
	for v in each_replaceNA(dv, 3)
		println(v)
	end

	dv = DataSeries(ComplexPair, 5)

	type MyType
		a::Int
		b::Int
	end

	dv = DataSeries(MyType, 5)
end
