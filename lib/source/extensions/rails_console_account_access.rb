module RailsConsoleAccountAccess
  def initialize(*arguments)
    return super(*arguments) if Rails.env.development? || Rails.env.test? || !Account.exists?

    if Rails.env.development? || Rails.env.test?
      actor = Account.with_role_state(:administrator).last
    else
      Rails.logger.info("Welcome! What is your email?")
      email = gets.chomp

      raise(NoConsoleAuthenticationProvidedError) if email.blank?

      actor = Account.find_by!(:email => email)

      Rails.logger.info("What is your password?")
    end

    PaperTrail.request.whodunnit = actor.email
    PaperTrail.request.controller_info = {
      :context_id => SecureRandom.uuid(),
      :actor_id => actor.id
    }

    super(*arguments)
  end
end

Rails::Console.prepend(RailsConsoleAccountAccess) if Rails.const_defined?("Console")
