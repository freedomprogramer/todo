require 'spec_helper'

describe TodoList do
  context "failure" do
    it "create a todo without todo_name" do
      expect{
        TodoList.create!(:todo_name => "")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "success" do
    it "create a todo with a valid arguments" do
      first_todo = TodoList.create!(todo_name: 'learn jquery')
      second_todo = TodoList.create!(todo_name: 'learn rails')

      expect(TodoList.all).to eq([first_todo, second_todo])
    end
  end
end
