Rails.application.config.middleware.use OmniAuth::Builder do
  silence_warnings do
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE unless Rails.env.production?
  end
  
  provider :google_oauth2, ENV["SE_GOOGLE_CLIENT_ID"],ENV["SE_GOOGLE_CLIENT_SECRET"], {
    :provider_ignores_state => Rails.env.development?,
    :scope => "userinfo.profile,userinfo.email",
    :prompt => "select_account consent",
    :skip_jwt => true
  }
end
