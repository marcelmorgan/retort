class Fixnum
	def bytes
		self
	end

	def kilobytes
		bytes / 1024.0
	end

	def kbs
		"#{sprintf('%.2f', kilobytes)}KB/s"
	end

	def megabytes
		kilobytes / 1024.0
	end

end

class Float
	def percent
		(self * 100).to_i
	end	

	def fmt
		"#{sprintf('%.2f', self)}"
	end
end

