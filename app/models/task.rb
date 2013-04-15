class Task < ActiveRecord::Base
  attr_accessible :status, :task_name, :user_id

  validates_presence_of :task_name, :status
  validates :status, :inclusion => { within: %w(undo done) }

  belongs_to :user
end
