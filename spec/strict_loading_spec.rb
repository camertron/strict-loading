# frozen_string_literal: true

require "spec_helper"
require "pry-byebug"

describe StrictLoading do
  describe "#strict_loading" do
    it "raises an error when attempting to access an unloaded relation" do
      list = TodoList.create(name: "Groceries")
      list.todo_items.create(name: "Celery")
      list.todo_items.create(name: "Carrots")

      list = TodoList.first
      list.strict_loading!

      expect { list.todo_items.to_a }.to raise_error(ActiveRecord::StrictLoadingViolationError) do |err|
        expect(err.message).to eq(
          "`TodoList` is marked for strict_loading. The TodoItem association named `:todo_items` cannot be lazily loaded."
        )
      end
    end
  end

  describe ".strict_loading" do
    it "raises an error when attempting to access an unloaded relation" do
      list = TodoList.create(name: "Groceries")
      list.todo_items.create(name: "Celery")
      list.todo_items.create(name: "Carrots")

      list = TodoList.strict_loading.first

      expect { list.todo_items.to_a }.to raise_error(ActiveRecord::StrictLoadingViolationError) do |err|
        expect(err.message).to eq(
          "`TodoList` is marked for strict_loading. The TodoItem association named `:todo_items` cannot be lazily loaded."
        )
      end
    end
  end
end
