Rails.application.config.middleware.use Browsernizer::Router do |config|
	config.supported "Internet Explorer", "9"
	config.location "http://browsehappy.com/"
	config.exclude %r{^assets}
end
