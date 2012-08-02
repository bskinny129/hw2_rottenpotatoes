class Movie < ActiveRecord::Base

	def self.all_ratings
		self.all(:select => 'rating').flatten.uniq.sort
	end

end
