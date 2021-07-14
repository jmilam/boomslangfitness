class AddZoomUrlToWorkoutClass < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_classes, :zoom_url, :text
  end
end
