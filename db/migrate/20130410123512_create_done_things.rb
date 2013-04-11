class CreateDoneThings < ActiveRecord::Migration
  def change
    create_table :done_things do |t|
      t.string :done_name

      t.timestamps
    end
  end
end
