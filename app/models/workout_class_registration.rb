class WorkoutClassRegistration < ApplicationRecord
  belongs_to :workout_class
  belongs_to :session

  scope :active_user_registrations, -> (user_name) { where(user_name: user_name, complete: false) }

  def self.map_details(user_name)
    WorkoutClassRegistration.active_user_registrations(user_name).map do |registration|
      {session_id: registration.session_id, workout_class_id: registration.workout_class_id, session: registration.session }
    end.uniq
  end
end
