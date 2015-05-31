module TrafficSpy
  class Request < ActiveRecord::Base
    belongs_to :page  
    belongs_to :visitor
  end
end
