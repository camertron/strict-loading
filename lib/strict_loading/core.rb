module StrictLoading
  module Core
    def self.included(base)
      base.include(InstanceMethods)
      base.extend(ClassMethods)

      base.mattr_accessor(:action_on_strict_loading_violation, instance_writer: false)
      base.action_on_strict_loading_violation = :raise
    end

    module InstanceMethods
      def strict_loading!
        @strict_loading = true
      end

      def strict_loading?
        @strict_loading
      end
    end

    module ClassMethods
      def strict_loading_violation!(owner:, reflection:)
        case ActiveRecord::Base.action_on_strict_loading_violation
        when :raise
          message = reflection.strict_loading_violation_message(owner)
          raise ActiveRecord::StrictLoadingViolationError.new(message)
        when :log
          name = "strict_loading_violation.active_record"
          ActiveSupport::Notifications.instrument(name, owner: owner, reflection: reflection)
        end
      end
    end
  end
end
