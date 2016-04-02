require 'censys/search/result'

module CenSys
  module Search
    class Certificate < Result

      def fingerprint_sha256
        @attributes['parsed.fingerprint_sha256']
      end

      def subject_dn
        @attributes['parsed.subject_dn']
      end

      def issuer_dn
        @attributes['parsed.issuer_dn']
      end

    end
  end
end
