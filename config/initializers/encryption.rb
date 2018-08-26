ENCRYPTION_KEY_GENERATOR = ActiveSupport::KeyGenerator.new(ENV.fetch("ENCRYPTION_SECRET"))
ENCRYPTION_KEY = ENCRYPTION_KEY_GENERATOR.generate_key(ENV.fetch("ENCRYPTION_SALT"), 32)
ENCRYPTOR = ActiveSupport::MessageEncryptor.new(ENCRYPTION_KEY)
