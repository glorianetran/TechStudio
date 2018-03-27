OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '475699984803-vqosjjspkpm49fbr5mp8rt1il28m9od9.apps.googleusercontent.com', 'In6PR7H7qrnF5dq0FSMnYY0_', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end