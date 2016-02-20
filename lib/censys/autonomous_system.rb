module CenSys
  class AutonomousSystem

    # @return [String]
    attr_reader :name

    # @return [String]
    attr_reader :rir

    # @return [String]
    attr_reader :routed_prefix

    # @return [String]
    attr_reader :country_code

    # @return [Array<Integer>]
    attr_reader :path

    # @return [String]
    attr_reader :organization

    # @return [Integer]
    attr_reader :asn

    # @return [String]
    attr_reader :description

    #
    # Initializes the Autonomous System (AS) information.
    #
    # @param [Hash{String => Object}] attributes
    #
    def initialize(attributes)
      @name          = attributes['name']
      @rir           = attributes['rir']
      @routed_prefix = attributes['routed_prefix']
      @country_code  = attributes['country_code']
      @path          = attributes['path']
      @organization  = attributes['organization']
      @asn           = attributes['asn']
      @description   = attributes['description']
    end

  end
end
