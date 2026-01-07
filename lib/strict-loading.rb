# frozen_string_literal: true

module StrictLoading
  autoload :AbstractReflection, "strict-loading/abstract_reflection"
  autoload :Association,        "strict-loading/association"
  autoload :Core,               "strict-loading/core"
  autoload :QueryMethods,       "strict-loading/query_methods"
  autoload :Relation,           "strict-loading/relation"
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
  require "strict-loading/railtie"
end
