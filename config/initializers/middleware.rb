Poutineer::Application.config.middleware.use(Rack::AuthenticationBearer)
Poutineer::Application.config.middleware.use(Rack::Deflater)
Poutineer::Application.config.middleware.use(Rack::Attack)
