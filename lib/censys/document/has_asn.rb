require 'censys/autonomous_system'

module CenSys
  class Document
    module HasASN
      #
      # Autonomous System (AS) information.
      #
      # @return [AutonomousSystem]
      #
      def autonomous_system
        @autonomous_system ||= AutonomousSystem.new(@attributes['autonomous_system'])
      end
    end
  end
end
