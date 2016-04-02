require 'censys/search/metadata'
require 'censys/search/ipv4'
require 'censys/search/website'
require 'censys/search/certificate'

module CenSys
  module Search
    class Response

      include Enumerable

      RESULTS = {
        ipv4:         IPv4,
        websites:     Website,
        certificates: Certificate
      }

      attr_reader :status

      attr_reader :metadata

      attr_reader :results

      #
      # @param [API] api
      #   Parent API.
      #
      # @param [:ipv4, :website, :certificate] result_type
      #   Result type.
      #
      # @param [Hash] params
      #   Search parameters.
      #
      # @param [Hash{String => Object}] response
      #   Response JSON Hash.
      #
      def initialize(api,result_type,params,response)
        @api         = api
        @result_type = result_type
        @params      = params

        @status   = response['status']
        @metadata = Metadata.new(response['metadata'])

        unless (result_class = RESULTS[@result_type])
          raise(ArgumentError,"invalid result type: #{@result_type}")
        end

        @results  = response['results'].map do |result|
          result_class.new(result,@api)
        end
      end

      #
      # Determines if the response has status of `ok`.
      #
      # @return [Boolean]
      #
      def ok?
        @status == 'ok'
      end

      #
      # Enumerates over all results in the response.
      #
      # @yield [result]
      #   The given block will be passed each result.
      #
      # @yieldparam [IPv4, Website, Certificate] result
      #   A result in the response.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      def each(&block)
        @results.each(&block)
      end

      #
      # Queries the next page of results.
      #
      # @return [Search::Response, nil]
      #   The next page of results or `nil` if there are no more pages.
      #
      def next_page
        if @metadata.page < @metadata.pages
          @api.search(@result_type,@params.merge(page: @metadata.page + 1))
        end
      end

      alias next next_page

      #
      # Enumerates through each page of results.
      #
      # @yield [page]
      #   The given block will be passed each page.
      #
      # @yieldparam [Response] page
      #   The response containing the next page of results.
      #
      # @return [Enumerator]
      #   If no block was given, an enumerator will be returned.
      #
      def each_page
        return enum_for(__method__) unless block_given?

        page = self

        while page
          yield page

          page = page.next_page
        end
      end

      #
      # Provides access to additional pages.
      #
      # @return [Enumerator]
      #
      def pages
        enum_for(:each_page)
      end

    end
  end
end
