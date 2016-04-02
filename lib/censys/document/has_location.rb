require 'censys/location'

module CenSys
  class Document
    module HasLocation
      #
      # Location information.
      #
      # @return [Location]
      #
      def location
        @location ||= Location.new(@attributes['location'])
      end
    end
  end
end
