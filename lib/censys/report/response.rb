require 'censys/report/metadata'

module CenSys
  module Report
    class Response

      include Enumerable

      # Response status.
      #
      # @return [String]
      attr_reader :status

      # Response results.
      #
      # @return [Hash{String => Fixnum}]
      attr_reader :results

      # Response metadata.
      #
      # @return [Metadata]
      attr_reader :metadata

      def initialize(response)
        @status  = response['status']
        @results = Hash[response['results'].map { |result|
          [result['key'], result['doc_count']]
        }]
        @metadata = Metadata.new(response['metadata'])
      end

      #
      # Determines if the response was OK.
      #
      # @return [Boolean]
      #
      def ok?
        @status == 'ok'
      end

      #
      # Enumerate through all response results.
      #
      # @yield [key, doc_count]
      #
      # @yieldparam [String] key
      #
      # @yieldparam [Fixnum] doc_count
      #
      def each(&block)
        @results.each(&block)
      end

    end
  end
end
