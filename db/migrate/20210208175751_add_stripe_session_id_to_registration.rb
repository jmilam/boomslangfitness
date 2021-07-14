class AddStripeSessionIdToRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :workout_class_registrations, :stripe_session_id, :text, null: false
  end
end
