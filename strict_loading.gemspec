$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'strict_loading/version'

Gem::Specification.new do |s|
  s.name     = 'strict_loading'
  s.version  = ::StrictLoading::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/camertron'

  s.description = s.summary = 'Strict loading for ActiveRecord 4.2.'
  s.platform = Gem::Platform::RUBY

  s.add_dependency 'railties', '~> 4.2.0'
  s.add_dependency 'activerecord', '~> 4.2.0'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'CHANGELOG.md', 'README.md', 'Rakefile', 'strict_loading.gemspec']
end
