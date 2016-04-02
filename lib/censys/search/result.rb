module CenSys
  module Search
    class Result

      #
      # Initializes the search result.
      #
      # @param [Hash{String => Object}] attributes
      #
      # @param [API] api
      #
      def initialize(attributes,api)
        @attributes = attributes
        @api        = api
      end

    end
  end
end
