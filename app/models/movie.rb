class Movie < ActiveRecord::Base

	def self.all_ratings
		self.select(:rating).uniq
	end

end
