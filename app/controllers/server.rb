require 'pry'
module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      source_hash = params[:source]
      converted_hash = {identifier: source_hash['identifier'], root_url: source_hash['rootUrl']}

      @source = Source.create(converted_hash)
      hash = {}
      hash['identifier']=@source.identifier
      if converted_hash[:identifier].nil? || converted_hash[:root_url].nil?
        status 400
      else
        status 200
        body "#{hash.to_json}"
      end
    end
  end
end


# register Sinatra::Partial
#   set :partial_template_engine, :erb
