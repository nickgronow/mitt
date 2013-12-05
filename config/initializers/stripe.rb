Rails.configuration.stripe = {
  :publisher_key => ENV['STRIPE_LIVE_PUBLISHER_KEY'],
  :secret_key      => ENV['STRIPE_LIVE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
