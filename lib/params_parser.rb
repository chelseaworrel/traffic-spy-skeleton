module TrafficSpy
  class ParamsParser
    attr_reader :payload, :sha

    def initialize(payload, sha)
      @payload = JSON.parse(payload)
      @sha = sha
    end

    def parse
      Payload.create({sha: sha})
      Page.create({url: payload["url"]})
      Visitor.create(user_agent: payload["userAgent"])
    end
  end
end
