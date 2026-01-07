# frozen_string_literal: true

module StrictLoading
  module QueryMethods
    def strict_loading
      spawn.strict_loading!
    end

    def strict_loading!
      self.strict_loading_value = true
      self
    end

    def strict_loading_value
      @values.fetch(:strict_loading, nil)
    end

    def strict_loading_value=(value)
      raise ImmutableRelation if @loaded
      check_cached_relation
      @values[:strict_loading] = value
    end
  end
end
