require 'user_agent'

module TrafficSpy
  class Visitor < ActiveRecord::Base
    # has_many  :requests
    validates :user_agent, presence: true

    def parsed_user_agent
      UserAgent.parse(user_agent)
    end

    def web_browser
      parsed_user_agent.browser
    end

    def operating_system
      parsed_user_agent.platform
    end

  end
end
