require "spec_helper"

feature "The86 Sample" do

  scenario "Front page redirects to /sites" do
    get "/"
    response.should redirect_to("/sites")
  end

  scenario "Sites page should have Sites heading" do
    get "/sites"
    response.body.should match("Sites")
  end

end
