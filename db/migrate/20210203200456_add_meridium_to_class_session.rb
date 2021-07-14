class AddMeridiumToClassSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :meridiem, :text, null: false, default: 'AM'
  end
end
