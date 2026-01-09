# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require "combustion"

Combustion.initialize! :active_record do
  if config.active_record.sqlite3
    config.active_record.sqlite3.represent_boolean_as_integer = true
  end
end

require "strict-loading"
require "rspec/rails"
require "database_cleaner"

module StrictLoading
  module SpecHelpers
    def with_violation_action(action)
      old_action = ActiveRecord::Base.action_on_strict_loading_violation
      ActiveRecord::Base.action_on_strict_loading_violation = action
      yield
    ensure
      ActiveRecord::Base.action_on_strict_loading_violation = old_action
    end
  end
end

RSpec.configure do |config|
  config.include(StrictLoading::SpecHelpers)

  DatabaseCleaner.strategy = :transaction

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }

  config.before { DatabaseCleaner.start }
  config.after  { DatabaseCleaner.clean }
end
