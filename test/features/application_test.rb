require './test/test_helper'

class ApplicationTest < FeatureTest

  def test_it_exists
    assert_equal 2, 1+1
  end

  def test_that_an_application_does_not_have_an_identifier
    visit '/sources/cheddar'

    within("#error") do
      assert page.has_content?("Identifier: 'cheddar' does not exist")
    end
  end

  def test_route_renders_correctly_to_application_details_erb
    # post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    visit '/sources/jumpstartlab'

    assert page.has_content?("jumpstartlab")
    assert page.has_content?("Application Details")
  end

  def create_visitors
    5.times do |i|
      TrafficSpy::Visitor.create("user_agent"=>"#{i}Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    end
  end

  def test_page_has_web_browser_breakdown
    visit '/sources/jumpstartlab'
    within("#browser_details") do
      assert page.has_content?("Chrome")
      assert page.has_content?("1")
    end

    create_visitors
    visit '/sources/jumpstartlab'

    within("#browser_details") do
      assert page.has_content?("Chrome")
      assert page.has_content?("6")
    end
  end

  def test_page_has_operating_system_breakdown
    visit '/sources/jumpstartlab'
    within("#os_details") do
      assert page.has_content?("OS X 10.8.2")
      assert page.has_content?("1")
    end

    create_visitors
    visit '/sources/jumpstartlab'

    within("#os_details") do
      assert page.has_content?("OS X 10.8.2")
      assert page.has_content?("6")
    end
  end

  def test_page_has_screen_resolution_across_all_requests
    visit '/sources/jumpstartlab'
    within("#resolution_details") do
      assert page.has_content?("1920x1280")
    end
    save_and_open_page
  end
end

#
# As a client with a registered application
# When I visit http://yourapplication:port/sources/IDENTIFIER and an identifer exists
# Then it should return a page that displays the
# Screen Resolution across all requests (resolutionWidth x resolutionHeight)
 #create 2 new table columns:
  # "resolutionWidth":"1920"
  # "resolutionHeight":"1280"
