require 'time'

module CenSys
  class Certificate < Document

    #
    # @return [String]
    #
    def raw
      @attributes['raw']
    end

    #
    # @return [Hash]
    #
    def parsed
      @attributes['parsed']
    end

    #
    # @return [Boolean]
    #
    def valid_nss
      @attributes['valid_nss']
    end

    # @return [Time]
    def validation_timestamp
      @validation_timestamp ||= Time.parse(@attributes['validation_timestamp'])
    end

  end
end
