OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], { scope: "basic_info, email, user_birthday, user_about_me, user_photos, user_interests, user_location, user_relationships, read_friendlists" }
end