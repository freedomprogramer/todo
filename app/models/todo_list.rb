class TodoList < ActiveRecord::Base
  attr_accessible :todo_name

  validates :todo_name, :presence => true
end
