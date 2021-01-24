Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development? || Rails.env.test?
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"],ENV["GOOGLE_CLIENT_SECRET"], {
    :provider_ignores_state => Rails.env.development?,
    :scope => "userinfo.profile,userinfo.email",
    :prompt => "select_account consent",
    :skip_jwt => true
  }
end
