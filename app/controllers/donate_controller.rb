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
		
		# Create the charge to the supporter
		customer = Stripe::Customer.create(
			:email => 'example@stripe.com',
			:card  => params[:token]
		)

		charge = Stripe::Charge.create(
			:customer    => customer.id,
			:amount      => round(@donation.amount * 100),
			:description => 'Sponsor Donation for Heart in the Tropics',
			:currency    => 'usd'
		)

		rescue Stripe::CardError => e
			flash[:error] = e.message
			redirect_to "donate/landing"
		end

		# Save this contact to the database
		@donation.save

		# Send an email to contact
		if @donation.support_type == 'sponsor'
			FormMailer.sponsor_email(@donation).deliver
		else
			FormMailer.auction_email(@donation).deliver
		end
	end
end
