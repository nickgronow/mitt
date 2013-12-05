class DonateController < ApplicationController
	def landing
	end

	def compatibility
	end

	def thanks
		# Save this contact to the database
		@donation = Donation.new
		@donation.name = params["full-name"]
		@donation.phone = params[:phone]
		@donation.email = params[:email]
		@donation.support_type = params["donate-amount"] ? 'sponsor' : 'auction'
		@donation.amount = params["donate-amount"] ? params["donate-amount"].gsub(/[^0-9.]/, '') : 0
		@donation.title = params[:title]
		@donation.save

		# Send an email to contact
		if @donation.support_type == 'sponsor'
			FormMailer.sponsor_email(@donation).deliver
		else
			FormMailer.auction_email(@donation).deliver
		end
	end
end
