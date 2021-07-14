class AddAvatarToWorkoutClass < ActiveRecord::Migration[5.2]
  def up
    add_attachment :workout_classes, :avatar
  end

  def down
    remove_attachment :workout_classes, :avatar
  end
end
