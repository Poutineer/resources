GOOGLE_PLACES_CLIENT = GooglePlaces::Client.new(
  Rails.application.credentials.public_send(Rails.env.to_sym).fetch(:google).fetch(:places).fetch(:secret)
)
