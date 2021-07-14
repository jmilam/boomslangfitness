class CreateWorkoutClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_classes do |t|
      t.integer :gym_id
      t.text :title, null: false
      t.string :description
      t.timestamps
    end
  end
end
