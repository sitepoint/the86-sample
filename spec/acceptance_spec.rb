require "spec_helper"

# This spec assumes the86 server contains a site called "Integration Test"
# with slug "integration-test", containing no conversations initially.
# It creates conversations, leaving the server in a state unsuitable for
# subsequent testing.
# See VCR: https://github.com/myronmarston/vcr

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

  context "signed in" do
    before { sign_in "John Citizen" }

    scenario "posting new conversation, reply and follow-up" do
      visit "/sites"
      click_link "Integration Test"

      fill_in "Post update", with: "What is NSString?"
      click_button "Post"
      expect_to_see "Integration Test", "What is NSString?", "John Citizen says"

      sign_in "Angry Internet Dweller"
      visit "/sites"
      click_link "Integration Test"
      fill_in "Post reply", with: "You are WRONG on the internet!"
      click_button "Reply"

      expect_to_see "Angry Internet Dweller, in reply to John Citizen, says:",
        "You are WRONG on the internet!"

      sign_in "Spammer"
      visit "/sites"
      click_link "Integration Test"
      fill_in "Follow up", with: "Excellent post. Check out my site."
      click_button "Follow up"

      expect_to_see "Spammer says:",
        "Excellent post. Check out my site."
    end

    scenario "attempt to post empty conversation" do
      pending
      visit "/sites/integration-test"
      click_button "Post"

      expect_to_see "Content can't be blank", "Please check the following:"
    end

  end

  context "signed out" do
    scenario "unable to post" do
      visit "/sites"
      click_link "Integration Test Site"
      expect_not_to_see "Post update"
    end
  end

end
