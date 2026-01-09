# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :todo_lists do |t|
    t.column :name, :string
  end

  create_table :todo_items do |t|
    t.column :name, :string
    t.references :todo_list
  end
end
