class Task < ActiveRecord::Base
  attr_accessible :status, :task_name, :user_id

  validates_presence_of :task_name, :status
  validates :status, :inclusion => { within: %w(undo done) }

  belongs_to :user


  class << self
    def today
      where('created_at >= ?', Time.zone.now.beginning_of_day)
    end

    def done_things
      order('updated_at DESC').where('status=?', 'done')
    end

    def undo_things
      where('status=?', 'undo')
    end

    def tracked_done_things(start_date, end_date)
      where(:updated_at => (start_date.to_date .. end_date.to_date))
    end
  end

end
