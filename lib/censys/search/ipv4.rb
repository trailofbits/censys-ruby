require 'censys/search/result'

module CenSys
  module Search
    class IPv4 < Result

      def address
        @attributes['address']
      end

      def protocols
        @attributes['protocols']
      end

      alias to_s address
      alias to_str address

    end
  end
end
