require './test/test_helper'
require 'byebug'

class ApplicationTest < FeatureTest

  def payload
    '{
      "url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -700"
      rake test
      respondedIn":37,
      "referredBy":"http://jumpstartlab.com",
      "requestType":"GET",
      "eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920",
      "resolutionHeight":"1280",
      "ip":"63.29.38.211"
    }'
  end

  def test_we_can_visit_this_route
    get "/sources/jumpstartlab"
    assert_equal 200, last_response.status
  end

  def test_that_an_application_does_not_have_an_identifier
    visit "/sources/not_registered"

    within("#error") do
      assert page.has_content?("Identifier: 'not_registered' does not exist")
    end
  end

  def test_route_renders_correctly_to_application_details_erb
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
  end

  def create_requests(num)
    TrafficSpy::Page.create("url" => "http://jumpstartlab.com/about", "id" => 2)

    1.upto(num) do |n|
      TrafficSpy::Request.create("responded_in" => n, "page_id" => 2)
    end

    num = num -= 2
    1.upto(num) do |n|
      TrafficSpy::Request.create("responded_in" => n, "page_id" => 1)
    end
  end

  def test_page_displays_most_to_least_requested_urls
    create_requests(5)
    visit '/sources/jumpstartlab'
    within("#sorted_urls") do
      assert page.has_content?("http://jumpstartlab.com/blog")
      assert page.has_content?("4")
      assert page.has_content?("http://jumpstartlab.com/about")
      assert page.has_content?("5")
    end

  end

  def test_page_displays_average_response_times_from_highest_to_lowest
    create_requests(5)
    visit '/sources/jumpstartlab'
    within("#response_times") do
      assert page.has_content?("http://jumpstartlab.com/blog")
      assert page.has_content?("10.75")
      assert page.has_content?("http://jumpstartlab.com/about")
      assert page.has_content?("3.0")
    end
  end
end
