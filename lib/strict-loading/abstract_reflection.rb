module StrictLoading
  module AbstractReflection
    def strict_loading_violation_message(owner)
      message = "`#{owner}` is marked for strict_loading."
      message << " The #{polymorphic? ? "polymorphic association" : "#{klass} association"}"
      message << " named `:#{name}` cannot be lazily loaded."
    end
  end
end
