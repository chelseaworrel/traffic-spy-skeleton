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

  def test_web_browser_breakdown
    post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    visit '/sources/jumpstartlab'

    assert page.has_content?("jumpstartlab")
    assert page.has_content?("Application Details")
  end

#
#     As a client with a registered application
#     When I visit http://yourapplication:port/sources/IDENTIFIER and an identifer exists
#      Then it should return a page that displays the Web browser breakdown across all requests (userAgent)
#
#      need a new route in the controller file -  get '/sources/IDENTIFIER'
# need a view erb: most_requested_urls
# table:  create pages table with urls and a relationship to sources
# create model based on table with relationships
# logic: as a client I want to see all the urls in order from most requested to least
# views: display urls sequentially within a table
  end


end
