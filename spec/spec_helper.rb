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

RSpec.configure do |config|
  DatabaseCleaner.strategy = :transaction

  config.before(:suite) { DatabaseCleaner.clean_with :truncation }

  config.before { DatabaseCleaner.start }
  config.after  { DatabaseCleaner.clean }
end
