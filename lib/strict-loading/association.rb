# frozen_string_literal: true

module StrictLoading
  module Association
    private

    def find_target(*args, **kwargs, &block)
      if violates_strict_loading?
        ::ActiveRecord::Base.strict_loading_violation!(owner: owner.class, reflection: reflection)
      end

      super
    end

    def violates_strict_loading?
      return unless owner.validation_context.nil?
      owner.strict_loading?
    end
  end
end
