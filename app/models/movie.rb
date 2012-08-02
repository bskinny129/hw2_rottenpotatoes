class Movie < ActiveRecord::Base

	def self.all_ratings
		self.all(:select => 'distinct(rating)').map { |movie| movie.rating }.sort
	end

end
