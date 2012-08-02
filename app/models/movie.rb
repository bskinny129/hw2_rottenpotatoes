class Movie < ActiveRecord::Base

	def self.all_ratings
		self.all.group(:rating)
	end

end
