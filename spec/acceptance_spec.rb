require "spec_helper"

feature "The86 Sample" do

  scenario "signing in" do
    visit "/"
    expect_not_to_see "Welcome, John Doe"
    sign_in "John Doe"
    expect_to_see "Welcome, John Doe"

    visit "/sign-out"
    expect_not_to_see "Welcome, John Doe"
  end

  scenario "Front page redirects to /sites" do
    get "/"
    response.should redirect_to("/sites")
  end

  scenario "Sites page should have Sites heading" do
    get "/sites"
    response.body.should match("Sites")
  end

end
