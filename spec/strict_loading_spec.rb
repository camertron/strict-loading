# frozen_string_literal: true

require "spec_helper"
require "pry-byebug"

describe StrictLoading do
  before(:each) do
    list = TodoList.create(name: "Groceries")
    list.todo_items.create(name: "Celery")
    list.todo_items.create(name: "Carrots")
  end

  describe "#strict_loading" do
    it "raises an error when attempting to access an unloaded relation" do
      list = TodoList.first
      list.strict_loading!

      expect { list.todo_items.to_a }.to raise_error(ActiveRecord::StrictLoadingViolationError) do |err|
        expect(err.message).to eq(
          "`TodoList` is marked for strict_loading. The TodoItem association named `:todo_items` cannot be lazily loaded."
        )
      end
    end

    it "logs violations instead of raising" do
      list = TodoList.first
      list.strict_loading!

      with_violation_action(:log) do
        events = []

        callback = lambda do |_name, _start, _finish, _id, payload|
          events << payload
        end

        ActiveSupport::Notifications.subscribed(callback, "strict_loading_violation.active_record") do
          list.todo_items.to_a
        end

        expect(events.size).to be > 0

        event = events[0]
        expect(event[:owner]).to eq(TodoList)
        expect(event[:reflection]).to eq(TodoList.reflect_on_association(:todo_items))
      end
    end
  end

  describe ".strict_loading" do
    it "raises an error when attempting to access an unloaded relation" do
      list = TodoList.strict_loading.first

      expect { list.todo_items.to_a }.to raise_error(ActiveRecord::StrictLoadingViolationError) do |err|
        expect(err.message).to eq(
          "`TodoList` is marked for strict_loading. The TodoItem association named `:todo_items` cannot be lazily loaded."
        )
      end
    end
  end
end
