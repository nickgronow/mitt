class DonateController < ApplicationController
	def landing
	end

	def compatibility
	end

	def thanks
		# Get the data
		@donation = Donation.new
		@donation.name = params["full-name"]
		@donation.phone = params[:phone]
		@donation.email = params[:email]
		@donation.support_type = params["donate-amount"] ? 'sponsor' : 'auction'
		@donation.amount = params["donate-amount"] ? params["donate-amount"].gsub(/[^0-9.]/, '') : 0
		@donation.title = params[:title]
		
    if @donation.support_type == 'sponsor'
      # Create the charge to the supporter
      token = JSON.parse params[:token]
      #raise RuntimeError, token['id']

      charge = Stripe::Charge.create(
        :card    => token['id'],
        :amount      => @donation.amount.round * 100,
        :description => 'Sponsor Donation for Heart in the Tropics',
        :currency    => 'usd'
      )
    end

		# Save this contact to the database
		@donation.save

		# Send an email to contact
		if @donation.support_type == 'sponsor'
			FormMailer.sponsor_email(@donation).deliver
		else
			FormMailer.auction_email(@donation).deliver
		end

		# In case of a Stripe error
		rescue Stripe::CardError => e
			flash[:error] = e.message
			redirect_to "/donate/landing"
	end
end
