require './test/test_helper'

class ApplicationTest < ControllersTest
  def test_it_exists
    assert_equal 2, 1+1
  end

  def test_that_an_application_does_not_have_an_identifier
    # post "/sources", { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }
    # post "/sources/jumpstartlab/data", JSON.parse(payload)
    # assert_equal 200, last_response.status
    assert_equal "Identifier does not exist", last_response.body
  end
end
