def no_repeats(year_start, year_end)
	years = []

	while(year_start <= year_end)
		if(year_start.to_s.split("").uniq == year_start.to_s.split(""))
			years << year_start
		end
		year_start += 1
	end
	years
end
