class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :workout_class_id
      t.integer :day
      t.text :class_time
      t.integer :duration
      t.timestamps
    end
  end
end
