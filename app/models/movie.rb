class Movie < ActiveRecord::Base

	def self.all_ratings
		self.all(:select => 'distinct(rating)').flatten.uniq.sort
	end

end
