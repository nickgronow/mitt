class Donation < ActiveRecord::Base
	def self.sort_by_type
		order(support_type: :asc, created_at: :desc)
	end
end
