module StrictLoading
  autoload :AbstractReflection, "strict_loading/abstract_reflection"
  autoload :Association,        "strict_loading/association"
  autoload :Core,               "strict_loading/core"
  autoload :QueryMethods,       "strict_loading/query_methods"
  autoload :Relation,           "strict_loading/relation"
end

module ActiveRecord
  class StrictLoadingViolationError < ::ActiveRecord::ActiveRecordError; end

  class Base
    # we can't do this in the railtie's initializer because we need to load it
    # earlier than ActiveRecord's own initializer
    include ::StrictLoading::Core
  end
end

if defined?(Rails)
  require "strict_loading/railtie"
end
