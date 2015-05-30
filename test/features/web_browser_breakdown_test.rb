require './test/test_helper'

# move to ApplicationDetailsTest
class WebBrowserBreakdownTest < ControllersTest

  As a client with a registered application
  When I visit http://yourapplication:port/sources/IDENTIFIER and an identifer exists
  Then it should return a page that displays the Web browser breakdown across all requests (userAgent)

  need a new route in the controller file -  get '/sources/IDENTIFIER'
  need a view erb: most_requested_urls
  table:  create pages table with urls and a relationship to sources
  create model based on table with relationships
  logic: as a client I want to see all the urls in order from most requested to least
  views: display urls sequentially within a table

end
