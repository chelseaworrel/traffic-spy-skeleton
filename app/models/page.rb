
module TrafficSpy
  class Page < ActiveRecord::Base
    validates  :url, presence: true, uniqueness: true

    has_many :requests
    belongs_to :source

    def times_visited
      requests.count
    end

    def average_response_time
      requests.average(:responded_in)
    end

    # def self.requests
    #   Request.where(page_id = id)
    # end

  end
end
