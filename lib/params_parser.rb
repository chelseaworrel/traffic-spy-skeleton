module TrafficSpy
  class ParamsParser
    attr_reader :payload, :sha

    def initialize(payload, sha)
      @payload = JSON.parse(payload)
      @sha = sha
    end

    def parse
      
      # if we need a relationship then this needs to be .new also
      Payload.create({sha: sha})
      # Page.create({url: payload["url"]})
      # Visitor.create(user_agent: payload["userAgent"],
      #         resolution_height: payload["resolutionHeight"],
      #          resolution_width: payload["resolutionWidth"])
      # Request.create({ responded_in: payload["respondedIn"] })

      page = Page.new
      page.url = payload["url"]
     
      request = Request.new
      request.responded_in = payload["respondedIn"]
      request.page_id = page.id
      # other attributes

      visitor = Visitor.new
      visitor.resolution_width = payload["resolutionWidth"]
      visitor.resolution_height = payload["resolutionHeight"]
      visitor.user_agent = payload["userAgent"] 
      visitor.request_id = request.id

       # test = Page.new
       # test.requests.create({page_id: Page.id})      
       # test.save
      page.save
      request.save
      visitor.save
    end
  end
end
