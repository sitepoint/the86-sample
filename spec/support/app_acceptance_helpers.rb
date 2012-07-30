require "cgi"

module AppAcceptanceHelpers

  def sign_in(as)
    visit "/sign-in?name=#{CGI.escape as}"
  end
end
