require 'censys/document'
require 'censys/document/has_services'
require 'censys/document/has_location'
require 'censys/document/has_asn'

require 'time'

module CenSys
  class IPv4 < Document

    include HasServices
    include HasLocation
    include HasASN

    def ip
      @attributes['ip']
    end

    def protocols
      @protocols ||= Array(@attributes['protocols'])
    end

    def to_s
      address
    end

  end
end
