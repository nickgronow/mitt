class FormMailer < ActionMailer::Base
	default to: ENV['CONTACT_EMAIL']

	def sponsor_email(sponsor)
		@supporter = sponsor
		mail(from: "\"#{@supporter.name}\" <#{@supporter.email}>", subject: "Donation made to Midnight in the Tropics")
	end

	def auction_email(lead)
		@supporter = lead
		mail(from: "\"#{@supporter.name}\" <#{@supporter.email}>", subject: "Auction item lead for Midnight in the Tropics")
	end
end
