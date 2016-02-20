module CenSys
  module Search
    class Metadata

      # @return [Integer]
      attr_reader :count

      # @return [String]
      attr_reader :query

      # @return [Integer]
      attr_reader :backend_time

      # @return [Integer]
      attr_reader :page

      # @return [Integer]
      attr_reader :pages

      #
      # Initializes the search metadata.
      #
      # @param [Hash{String => Object}] metadata
      #
      def initialize(metadata)
        @count = metadata['count']
        @query = metadata['query']
        @backend_time = metadata['backend_time']

        @page  = metadata['page']
        @pages = metadata['pages']
      end

    end
  end
end
