# strict-loading

Backport of Rails 6.1's [strict loading](https://guides.rubyonrails.org/active_record_querying.html#strict-loading) feature for earlier versions of Rails.

## Usage

Add this line to your Gemfile:

```ruby
gem "strict-loading"
```

Then execute:
```ruby
bundle install
```

This backport is designed to mimic the Rails 6.1 feature in both behavior and API (although it is currently not a complete implementation). Please see the official Rails [documentation](https://guides.rubyonrails.org/active_record_querying.html#strict-loading) for additional usage information.

### Violation Modes

Strict loading can report violations in two ways:

1. `:raise`: Violations will raise errors indicating which association on which model was accessed.
2. `:log`: Violations use the `ActiveSupport::Notifications` system and log violation messages under the notification name `strict_loading_violation.active_record`.

The default violation mode is `:raise`. To set the violation mode, add the following line to application.rb or one of your environments (eg. config/development.rb):

```ruby
config.active_record.action_on_strict_loading_violation = :log
```

Setting up a subscriber to listen for violations can be done like so:

```ruby
ActiveSupport::Notifications.subscribe("strict_loading_violation.active_record") do |name, start, finish, id, payload|
  # payload is a hash of the form { reflection:, owner: } where the reflection is the
  # association, eg. ActiveRecord::Reflection::HasManyReflection, and `owner:` is the
  # ActiveRecord model class.
end
```
