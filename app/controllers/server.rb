require 'digest'
require 'byebug'
require 'json'

module TrafficSpy
  class Server < Sinatra::Base

    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      # status SourceResponder.new(params).status
      # body SourceResponder.new(params).body
      @source_responder = SourceResponder.new(params) 
      source_data = { identifier: params["identifier"],
                      root_url: params["rootUrl"] }

      if Source.exists?(source_data)
        status 403
        body "Identifier already exists"
      else

        @source = Source.new(source_data)
        if @source.save
          hash = {identifier: @source.identifier}
          body hash.to_json
        else
          status 400
          body "Missing parameter, the required parameters are 'identifier' and 'rootUrl'"
        end
      end
    end

    post '/sources/:identifier/data' do |identifier|
      # status PayloadResponder.new(params).status
      # body PayloadResponder.new(params).body
      if Source.exists?(identifier: identifier)
        sha = Payload.generate_sha(params.values.join)
        if Payload.exists?(sha: sha)
          status 403
          body "Duplicate payload detected!"
        elsif params[:payload].blank?
          status 400
          body "Payload missing"
        else
          payload = params['payload']
          parser = ParamsParser.new(payload, sha)
          parser.parse
          body "success"
        end
      else
        status 403
        body "Application not registered"
      end
    end

    #  When an identifer exists return a page that displays the following:
    #  Most requested URLS to least requested URLS (url)

    get '/sources/:identifier' do |identifier|
      if Source.exists?(identifier: identifier)
      else
        @error_message = "That #{identifier} does not exist"
        redirect not_found
      end
      #if the identifier do not exist then we need to return an error message
      #identifier: jumpstartlab
    end
  end
end

# need a new route in the controller file -  get '/sources/IDENTIFIER'
# need a view erb: most_requested_urls
# table:  create pages table with urls and a relationship to sources
# create model based on table with relationships
# logic: as a client I want to see all the urls in order from most requested to least
# views: display urls sequentially within a table
