module CenSys
  class Document

    #
    # Initializes the document.
    #
    # @param [Hash{String => Object}] attributes
    #
    def initialize(attributes)
      @attributes = attributes
    end

    #
    # Tags.
    #
    # @return [Array<String>]
    #
    def tags
      @attributes['tags']
    end

    #
    # Time last updated at.
    #
    # @return [Time]
    #
    def updated_at
      @updated_at ||= Time.parse(@attributes['updated_at'])
    end

    #
    # Additional document metadata.
    #
    # @return [Hash{String => Object}]
    #
    def metadata
      @attributes['metadata']
    end

  end
end
