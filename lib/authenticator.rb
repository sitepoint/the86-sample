class Authenticator

  def initialize(session)
    @session = session
  end

  def current_user
    current_user_or_nil || raise(NoUser)
  end

  def current_user?
    !!current_user_or_nil
  end

  def sign_in(user)
    @session[:user_id] = user.id
  end

  def sign_out
    @session.delete :user_id
  end

  attr_writer :user_finder

  def user_finder
    @user_finder || User.method(:find)
  end

  Error = Class.new(StandardError)
  NoUser = Class.new(Error)

  private

  def current_user_or_nil
    if id = @session[:user_id]
      user_finder.call(id)
    else
      nil
    end
  end

end
