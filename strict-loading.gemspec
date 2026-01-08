$:.unshift File.join(File.dirname(__FILE__), "lib")
require "strict-loading/version"

Gem::Specification.new do |s|
  s.name     = "strict-loading"
  s.version  = ::StrictLoading::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/camertron"

  s.description = s.summary = "A backport of ActiveRecord strict loading feature for Rails < 6.1."
  s.platform = Gem::Platform::RUBY

  s.add_dependency "railties", ">= 4.2.0", "< 6.1"
  s.add_dependency "activerecord", ">= 4.2.0", "< 6.1"

  s.require_path = "lib"
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "CHANGELOG.md", "README.md", "Rakefile", "strict-loading.gemspec"]
end
