class AddSessionIdToWorkoutRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_class_registrations, :session_id, :integer, null: false
  end
end
