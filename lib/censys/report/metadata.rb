module CenSys
  module Report
    class Metadata

      # @return [Fixnum]
      attr_reader :count

      # @return [Fixnum]
      attr_reader :backend_time

      # @return [Fixnum]
      attr_reader :non_null_count

      # @return [Fixnum]
      attr_reader :other_result_count

      # @return [Fixnum]
      attr_reader :buckets

      # @return [Fixnum]
      attr_reader :error_bound

      # @return [String]
      attr_reader :query

      #
      # Initializes the report metadata.
      #
      # @param [Hash{String => Object}] attributes
      #
      def initialize(attributes)
        @count              = attributes['count']
        @backend_time       = attributes['backend_time']
        @non_null_count     = attributes['nonnull_count']
        @other_result_count = attributes['other_result_count']
        @buckets            = attributes['buckets']
        @error_bound        = attributes['error_bound']
        @query              = attributes['query']
      end

    end
  end
end
