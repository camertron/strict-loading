# frozen_string_literal: true

module StrictLoading
  class Railtie < Rails::Railtie
    initializer "strict_loading.initialize" do
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Relation.prepend(::StrictLoading::Relation)
        ::ActiveRecord::Relation.include(::StrictLoading::QueryMethods)
        # ::ActiveRecord::Associations::Association.prepend(::StrictLoading::Association)
        ::ActiveRecord::Associations::HasManyAssociation.prepend(::StrictLoading::Association)
        ::ActiveRecord::Associations::SingularAssociation.prepend(::StrictLoading::Association)
        ::ActiveRecord::Associations::HasManyThroughAssociation.prepend(::StrictLoading::Association)
        ::ActiveRecord::Associations::CollectionAssociation.prepend(::StrictLoading::Association)
        ::ActiveRecord::Reflection::AbstractReflection.include(::StrictLoading::AbstractReflection)

        if (action = Rails.application.config.active_record.action_on_strict_loading_violation)
          self.action_on_strict_loading_violation = action
        end
      end
    end
  end
end
