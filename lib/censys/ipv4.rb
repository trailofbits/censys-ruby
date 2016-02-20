require 'censys/location'
require 'censys/autonomous_system'

require 'time'

module CenSys
  class IPv4

    # IPv4 address.
    #
    # @return [String]
    attr_reader :address

    #
    # Initializes the IPv4 object.
    #
    # @param [String] address
    #   The identifying address.
    #
    # @param [API] api
    #   Parent API.
    #
    def initialize(attributes,api)
      @address   = attributes['ip']
      @protocols = Array(attributes['protocols'])
      @api       = api
    end

    #
    # Open ports.
    #
    # @return [Hash{String => Hash}]
    #
    def ports
      @ports ||= Hash[data.select { |key,value| key =~ /\A\d+\z/ }]
    end

    #
    # Tags.
    #
    # @return [Array<String>]
    #
    def tags
      data['tags']
    end

    #
    # Time last updated at.
    #
    # @return [Time]
    #
    def updated_at
      Time.parse(data['updated_at'])
    end

    #
    # Location information.
    #
    # @return [Location]
    #
    def location
      Location.new(data['location'])
    end

    #
    # Autonomous System (AS) information.
    #
    # @return [AutonomousSystem]
    #
    def autonomous_system
      AutonomousSystem.new(data['autonomous_system'])
    end

    def protocols
      data['protocols']
    end

    def metadata
      data['metadata']
    end

    def to_s
      @address
    end

    private

    def data
      @data ||= @api.view(:ipv4,@address)
    end

  end
end
