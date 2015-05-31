
module TrafficSpy
  class Page < ActiveRecord::Base
    has_many :requests
    belongs_to :source
  end
end
