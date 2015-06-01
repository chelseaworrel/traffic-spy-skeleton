
module TrafficSpy
  class Page < ActiveRecord::Base
    validates  :url, presence: true, uniqueness: true

    has_many :requests
    belongs_to :source

    def average_time
      requests.average(:responded_in)
    end

    # def self.requests
    #   Request.where(page_id = id)
    # end

  end
end
