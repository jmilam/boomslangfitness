class CreateDislikes < ActiveRecord::Migration[5.2]
  def change
    create_table :dislikes do |t|
      t.integer :workout_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
