require "authenticator"

module AuthenticationHelper

  def authentication_path(provider)
    "/auth/#{provider}"
  end

  def current_user?
    authenticator.current_user?
  end

  def current_user
    authenticator.current_user
  end

  private

  def authenticator
    @authenticator ||= Authenticator.new(session).tap do |auth|
      auth.user_finder = User.tap{ |k| k.session = session }.method(:find)
    end
  end

end
