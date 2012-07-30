module WebAcceptanceHelpers

  def refresh_page
    visit page.current_url
  end

  def expect_to_see *expectations
    Array(expectations).each do |expectation|
      if expectation.is_a? Regexp
        # as per cucumber's web_steps.rb
        page.should have_xpath('//*', :text => expectation)
      else
        page.should have_content expectation
      end
    end
  end

  def expect_not_to_see *expectations
    Array(expectations).each do |expectation|
      if expectation.is_a? Regexp
        # as per cucumber's web_steps.rb
        page.should_not have_xpath('//*', :text => expectation)
      else
        page.should_not have_content expectation
      end
    end
  end

  def click_and_expect click_hash
    click_hash.each_pair do |link, strings|
      click_link link
      expect_to_see *Array(strings)
    end
  end

  def fill_in_form values
    values.each_pair do |field, value|
      fill_in field, with: value
    end
  end

end
