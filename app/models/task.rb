class Task < ActiveRecord::Base
  attr_accessible :status, :task_name, :user_id

  validates_presence_of :task_name, :status
  validates :status, :inclusion => { within: %w(undo done) }

  belongs_to :user

  def self.today
    where('created_at >= ?', Time.zone.now.beginning_of_day)
  end
end
