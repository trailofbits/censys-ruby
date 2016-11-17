require 'censys/exceptions'
require 'censys/search'
require 'censys/report'
require 'censys/ipv4'
require 'censys/website'
require 'censys/certificate'

require 'net/https'
require 'json'

module CenSys
  class API

    VERSION = 1

    HOST = 'www.censys.io'

    URL = "https://#{HOST}/api/v#{VERSION}"

    class Resource

      def initialize(type,api)
        @type = type
        @api  = api
      end

      #
      # @see API#search
      #
      def search(params={})
        @api.search(@type,params)
      end

      #
      # @see API#view
      #
      def [](id)
        @api.view(@type,id)
      end

      #
      # @see API#report
      #
      def report(params)
        @api.report(@type,params)
      end

    end

    # API UID.
    #
    # @return [String]
    attr_reader :id

    # API Secret.
    #
    # @return [String]
    attr_reader :secret

    # IPv4 resource.
    #
    # @return [Resource]
    attr_reader :ipv4

    # Websites resource.
    #
    # @return [Resource]
    attr_reader :websites

    # Certificates resource.
    #
    # @return [Resource]
    attr_reader :certificates

    #
    # Initializes the API.
    #
    # @param [String] id
    #   The API UID used for authentication.
    #
    # @param [String] secret
    #   The API secret used for authentication.
    #
    # @raise [ArgumentError]
    #   Either `id` or `secret` was `nil` or empty.
    #
    # @see https://censys.io/account
    #   CenSys - My Account
    #
    def initialize(id=ENV['CENSYS_ID'],secret=ENV['CENSYS_SECRET'])
      if (id.nil? || id.empty?)
        raise(ArgumentError,"'id' argument required")
      end

      if (secret.nil? || secret.empty?)
        raise(ArgumentError,"'secret' argument required")
      end

      @id, @secret = id, secret

      @ipv4         = Resource.new(:ipv4,self)
      @websites     = Resource.new(:websites,self)
      @certificates = Resource.new(:certificates,self)
    end

    #
    # Performs a search.
    #
    # @param [:ipv4, :websites, :certificates] resource
    #
    # @param [Hash] params
    #   Optional search params.
    #
    # @option params [String] :query
    #   The query to perform.
    #
    # @option params [Fixnum] :page
    #   Optional page number to request.
    #
    # @option params [Array<String>] :fields
    #   Optional list of fields to include in the results.
    #
    # @api private
    #
    def search(resource,params={})
      post("/search/#{resource}",params) do |json|
        Search::Response.new(self,resource,params,json)
      end
    end

    DOCUMENTS = {
      ipv4:         IPv4,
      websites:     Website,
      certificates: Certificate
    }

    #
    # Requests the document of the given type.
    #
    # @param [:ipv4, :websites, :certificates] resource
    #
    # @param [String] id
    #
    # @api private
    #
    def view(resource,id)
      document_class = DOCUMENTS.fetch(resource)

      get("/view/#{resource}/#{id}") do |attributes|
        document_class.new(attributes)
      end
    end

    #
    # Builds a report of aggregate data.
    #
    # @param [:ipv4, :websites, :certificates] resource
    #
    # @param [Hash] params
    #
    # @option params [String] :query
    #   (**Required**) The query to perform.
    #
    # @option params [String] :field
    #   (**Required**) The field to aggregate.
    #
    # @option params [Fixnum] :buckets
    #   Optional maximum number of values to be returned.
    #
    # @option params
    #
    def report(resource,params)
      unless params[:query]
        raise(ArgumentError,"must specify the :query param")
      end

      unless params[:field]
        raise(ArgumentError,"must specify the :field param")
      end

      post("/report/#{resource}",params) do |response|
        Report::Response.new(response)
      end
    end

    private

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

    def validate_index!(index)
      unless INDEXES.include?(index)
        raise(ArgumentError,"unsupported index type: #{index}")
      end
    end

  end
end
