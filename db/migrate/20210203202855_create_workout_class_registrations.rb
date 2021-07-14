class CreateWorkoutClassRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_class_registrations do |t|
      t.integer :workout_class_id
      t.text :user_name

      t.timestamps
    end
  end
end
