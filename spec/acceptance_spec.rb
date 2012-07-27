require "spec_helper"

feature "The86 Sample" do

  scenario "Front page redirects to /sites" do
    get "/"
    response.should redirect_to("/sites")
  end

end
