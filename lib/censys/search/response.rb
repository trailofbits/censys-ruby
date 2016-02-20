require 'censys/search/metadata'
require 'censys/ipv4'
require 'censys/website'
require 'censys/certificate'

module CenSys
  module Search
    class Response

      RESULTS = {
        ipv4:        IPv4,
        website:     Website,
        certificate: Certificate
      }

      attr_reader :status

      attr_reader :metadata

      attr_reader :results

      #
      # @param [Hash{String => Object}] response
      #   Response JSON Hash.
      #
      # @param [API] api
      #   Parent API.
      #
      # @param [:ipv4, :website, :certificate] result_type
      #   Result type.
      #
      def initialize(response,result_type,api)
        @status   = response['status']
        @metadata = Metadata.new(response['metadata'])

        unless (result_class = RESULTS[result_type])
          raise(ArgumentError,"invalid result type: #{result_type}")
        end

        @results  = response['results'].map do |result|
          result_class.new(result,api)
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

    end
  end
end
