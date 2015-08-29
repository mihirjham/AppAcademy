class Array
	def my_each(&prc)
		self.length.times do |i|
			prc.call(self[i])
		end
	end

	def my_select(&prc)
		ary = []
		self.length.times do |i|
			if(prc.call(self[i]))
				ary << self[i]
			end
		end
		return ary;
	end

	def my_reject(&prc)
		ary = self.my_select(&prc)
		return self - ary
	end

	def my_any?(&prc)
		self.length.times do |i|
			if(prc.call(self[i]))
				return true
			end
		end
		false
	end

	def my_all?(&prc)
		self.length.times do |i|
			if(!prc.call(self[i]))
				return false
			end
		end
		return true
	end

	def my_flatten
		ary = []
		self.each do |el|
			if(el.class == Array)
				ary += el.my_flatten
			else
				ary << el
			end
		end
		return ary;
	end

	def my_zip(*args)
		ary = [];
		self.each_with_index do |el, i|
			temp = [el]
			args.each do |arg|
				temp << arg[i]
			end
			ary << temp
		end
		return ary;
	end

	def my_rotate(n=1)
		ary = self.dup;
		

		n.abs.times do
			if(n < 0)
				ary.unshift(ary.pop)
			else
				ary.push(ary.shift)
			end
		end 
		return ary
	end

	def my_join(delimiter="")
		str = ""
		self.each_with_index do |el,i|
			str << el.to_s
			
			if(i != self.length-1)
				str << delimiter
			end
		end
		return str
	end

	def my_reverse
		ary = []
		self.length.times do |i|
			ary << self[self.length-1-i]
		end
		return ary;
	end
end	