class AddCostToWorkoutClass < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_classes, :cost, :float, null: false, default: 0.0
  end
end
