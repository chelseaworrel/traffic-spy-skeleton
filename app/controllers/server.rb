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
        @identifier = identifier
        @visitors   = Visitor.all
        # web browsers
        grouped_browsers  = @visitors.group_by { |visitor| visitor.web_browser }
        @counted_browsers = grouped_browsers.map do |browser, collection|
                              [browser, collection.count]
                            end
        # operating_system
        grouped_os  = @visitors.group_by { |visitor| visitor.operating_system }
        @counted_os = grouped_os.map do |os, collection|
                        [os, collection.count]
                      end
        # resolutions
        @resolutions = @visitors.map do |visitor|
                         "#{visitor.resolution_width}x#{visitor.resolution_height}"
                       end
        #sorting urls
        @pages = Page.all
        @counted_urls = @pages.map do |page|
          [page.url, page.requests.count]
        end.sort_by {|url, num| num}.reverse


        #sorting response times

        # @url = TrafficSpy::Page.where(url: "http://jumpstartlab.com/blog")

        # @pages = Page.all
        # @average_times = @pages.map{ |page| { page.url => page.average_time } }

        # @test = @pages.map do |page|
        #           page.requests
        #         end
        # @requests = Request.all
        #
        # loop thru urls and average the response times.
        # then we need to display them from longest to slowest
        #
        #
       # @request = TrafficSpy::Request.where(@request.page_id == 1)
       # Then it should return a page that displays the
       # Longest, average response time per URL to shortest, average response time per URL

        erb :application_details
      else
        @error_message = "Identifier: '#{identifier}' does not exist"
        redirect not_found
      end
    end

    get '/sources/:identifier/urls/:relative/:path' do |identifier, relative, path|
      if Source.exists?(identifier: identifier)

      else
        @error_message = "Identifier: '#{identifier}' does not exist"
        redirect not_found
      end
    end

  end
end

# most visited urls html




# <!-- <% #@grouped_requests_by_url.each do |url, times_visited| %> -->
# <!-- <tr> -->
#   <!-- <td style="text-align: center"><%= #times_visited %></td> -->
#   <!-- <td style="text-align: center"><%= #url %></td> -->
# <!-- </tr> -->
# <%# end %>





# AVERAGE RESPONSE TIMES
# <% @average_times.each do |url, avereage_time| %>
#   <tr>
#     <td><%= url %></td>
#     <td><%= avereage_time %></td>
#   </tr>
# <% end %>
