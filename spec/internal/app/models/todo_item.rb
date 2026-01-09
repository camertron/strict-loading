# frozen_string_literal: true

class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
end
