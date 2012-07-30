class AuthenticationController < ApplicationController

  def sign_in
    authenticator.sign_in(user_from_url)
    redirect_to root_url
  end

  def sign_out
    authenticator.sign_out
    redirect_to root_url
  end

  private

  def user_from_url
    name = params[:name]
    user_class.where(name: name).first || create_user(name)
  end

  def user_class
    User.tap { |u| u.session = session }
  end

  def create_user(name)
    remote = The86::Client.users.create(name: name)
    user_class.create(name: name, oauth_token: remote.access_tokens.first.token)
  end

end
