module TrafficSpy
  class Request < ActiveRecord::Base
    belongs_to :page
    belongs_to :visitor

    def page_url
      Page.find(page_id).url
    end
  end
end
