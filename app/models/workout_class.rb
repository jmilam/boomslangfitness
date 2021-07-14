class WorkoutClass < ApplicationRecord
  belongs_to :gym
  has_many :sessions
  has_many :workout_class_registrations

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                           default_url: "fitnessone.jpeg",
                           storage: :cloudinary,
                           path: ':id/:style/:filename'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def add_new_workout_sessions(session_data, method_param=:create)
    session_data.each do |session_details|
      if method_param == :create
        session_day = session_details[0]
        session_duration = session_details[2]
        meridiem = parse_session_meridiem(session_details[1])
        hours, minutes = parse_hours_minutes(session_details[1])
        parsed_time = parse_time(hours, minutes)
      else
        if session_details[0] == "*"
          session_day = session_details[1]
          session_duration = session_details[3]
          meridiem = parse_session_meridiem(session_details[2])
          hours, minutes = parse_hours_minutes(session_details[2])
          parsed_time = parse_time(hours, minutes)
        else
          next
        end
      end
      sessions.new(day: session_day, class_time: parsed_time, duration: session_duration, meridiem: meridiem)
    end
  end

  private

  def parse_session_meridiem(time_24_hours)
    time_24_hours < "12:00" ? "AM" : "PM"
  end

  def parse_hours_minutes(time)
    [time.match(/\d+/).to_s.to_i, time.match(/:\d+/).to_s]
  end

  def parse_time(hours, minutes)
    hours > 12 ? minutes.prepend((hours - 12).to_s) : minutes.prepend(hours.to_s)
  end
end
