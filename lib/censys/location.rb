module CenSys
  class Location

    # @return [String]
    attr_reader :postal_code

    # @return [String]
    attr_reader :city

    # @return [String]
    attr_reader :province

    # @return [String]
    attr_reader :country

    # @return [String]
    attr_reader :continent

    # @return [String]
    attr_reader :registered_country

    # @return [String]
    attr_reader :registered_country_code

    # @return [String]
    attr_reader :timezone

    # @return [Float]
    attr_reader :latitude

    # @return [Float]
    attr_reader :longitude

    #
    # Initializes the location information.
    #
    # @param [Hash{String => Object}] attributes
    #
    def initialize(attributes)
      @postal_code = attributes['postal_code']
      @city        = attributes['city']
      @province    = attributes['province']
      @country     = attributes['country']
      @continent   = attributes['continent']

      @registered_country      = attributes['registered_country']
      @registered_country_code = attributes['registered_country_code']

      @timezone = attributes['timezone']

      @latitude  = attributes['latitude']
      @longitude = attributes['longitude']
    end

  end
end
