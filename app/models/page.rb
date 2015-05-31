
module TrafficSpy
  class Page < ActiveRecord::Base

    validates  :url, presence: true, uniqueness: true

    has_many :requests
    belongs_to :source

    
  end
end
