class AddCompleteToWorkoutClassRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_class_registrations, :complete, :boolean, null: false, default: false
  end
end
