require './test/test_helper'

class ApplicationUrlStatisticsTest < FeatureTest

  def test_route_returns_error_when_source_not_registered
    visit "/sources/not_registered/urls/blog/1"

    within("#error") do
      assert page.has_content?("Identifier: 'not_registered' does not exist")
    end
  end

end
