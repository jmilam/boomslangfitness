class AddAdditionalWorkoutDetailRepColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_details, :rep_7_weight, :integer
    add_column :workout_details, :rep_8_weight, :integer
    add_column :workout_details, :rep_9_weight, :integer
    add_column :workout_details, :rep_10_weight, :integer
  end
end
