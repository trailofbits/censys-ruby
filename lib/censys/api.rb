require 'censys/exceptions'
require 'censys/search'

require 'net/https'
require 'json'

module CenSys
  class API

    VERSION = 1

    HOST = 'www.censys.io'

    URL = "https://#{HOST}/api/v#{VERSION}"

    INDEXES = [:ipv4, :websites, :certificates]

    # API UID.
    #
    # @return [String]
    attr_reader :id

    # API Secret.
    #
    # @return [String]
    attr_reader :secret

    #
    # Initializes the API.
    #
    # @param [String] id
    #   The API UID used for authentication.
    #
    # @param [String] secret
    #   The API secret used for authentication.
    #
    # @see https://censys.io/account
    #   CenSys - My Account
    #
    def initialize(id=ENV['CENSYS_ID'],secret=ENV['CENSYS_SECRET'])
      @id, @secret = id, secret
    end

    #
    # Performs a search.
    #
    # @param [:ipv4, :websites, :certificates] index
    #
    # @param [Hash] params
    #
    def search(index,params={})
      validate_index! index

      post("/search/#{index}",params) do |json|
        Search::Response.new(self,index,params,json)
      end
    end

    #
    # Retrieves additional data.
    #
    # @param [:ipv4, :websites, :certificates] index
    #
    # @param [String] id
    #
    def view(index,id)
      validate_index! index

      get("/view/#{index}/#{id}") do |json|
        json
      end
    end

    private

    def validate_index!(index)
      unless INDEXES.include?(index)
        raise(ArgumentError,"unsupported index type: #{index}")
      end
    end

    #
    # Returns a URL for the API sub-path.
    #
    # @param [String] path
    #   Path relative to `/api/v1`.
    #
    # @return [URI::HTTPS]
    #   Fully qualified URI.
    #
    def url_for(path)
      URI(URL + path)
    end

    #
    # Sends the HTTP request and handles the response.
    #
    # @param [Net::HTTP::Get, Net::HTTP::Post] req
    #   The prepared request to send.
    #
    # @yield [json]
    #   The given block will be passed the parsed JSON.
    #
    # @yieldparam [Hash{String => Object}] json
    #   The parsed JSON.
    #
    # @raise [NotFound, RateLimited, InternalServerError, ResponseError]
    #   If an error response is returned, the appropriate exception will be
    #   raised.
    #
    def request(req)
      Net::HTTP.start(HOST, 443, use_ssl: true) do |http|
        response = http.request(req)

        case response.code
        when '200' then yield JSON.parse(response.body)
        when '302' then raise(AuthenticationError,response.body)
        when '404' then raise(NotFound,"#{req.uri} not found")
        when '429' then raise(RateLimited,"rate limit exceeded")
        when '500' then raise(InternalServerError,response.body)
        else
          raise(ResponseError,"unsupported response code returned: #{response.code}")
        end
      end
    end

    #
    # Creates a new HTTP GET request.
    #
    # @param [String] path
    #
    # @see #request
    #
    def get(path,&block)
      get = Net::HTTP::Get.new(url_for(path))
      get.basic_auth @id, @secret

      request(get,&block)
    end

    #
    # Creates a new HTTP POST request.
    #
    # @param [String] path
    #
    # @param [#to_json] json
    #
    # @see #request
    #
    def post(path,json,&block)
      post = Net::HTTP::Post.new(url_for(path))
      post.basic_auth @id, @secret
      post.content_type = 'application/json'
      post.body = json.to_json

      request(post,&block)
    end

  end
end
