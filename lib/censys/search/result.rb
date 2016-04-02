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

      #
      # The field names.
      #
      # @return [Array<String>]
      #
      def fields
        @attributes.keys
      end

      #
      # Determines whether the field exists.
      #
      # @param [String] name
      #
      # @return [Boolean]
      #
      def field?(name)
        @attributes.has_key?(name)
      end

      #
      # Provides arbitrary access to the result fields.
      #
      # @param [String] name
      #   The dot-separated field name.
      #
      # @return [Object]
      #
      def [](name)
        @attributes[name]
      end

    end
  end
end
