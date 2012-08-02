class Movie < ActiveRecord::Base

	def self.all_ratings
		self.select(:rating).rating.uniq
	end

end
