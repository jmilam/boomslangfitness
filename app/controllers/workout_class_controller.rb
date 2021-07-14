class WorkoutClassController < ApplicationController
	skip_before_action :authenticate_user!

  def index
    @user = current_user
    @gym = @user.gym
    @classes = @gym.workout_classes.where(active: true).sort_by(&:title)
  end

  def create
    WorkoutClass.transaction do 
      session_data = params[:selected_days].split(',').zip(params[:selected_class_times].split(','), params[:selected_durations].split(','))

      @gym = Gym.find(params[:workout_class][:gym_id])

      @workout_class = @gym.workout_classes.new(workout_class_params)
      @workout_class.add_new_workout_sessions(session_data)      
      @workout_class.save!
    end
    render 'success'
  end

	def update
    WorkoutClass.transaction do 
      session_data = params[:selected_session_ids].split(',')
        .zip(params[:selected_days].split(','), params[:selected_class_times].split(','), params[:selected_durations].split(','))

      @workout_class = WorkoutClass.find(params[:workout_class][:id])

      @workout_class.add_new_workout_sessions(session_data, :update)
      @workout_class.update(workout_class_params)
    end

    render 'success'
	end

  def get_workout_sessions
    workout_class = WorkoutClass.find(params[:id])
    workout_sessions = workout_class.sessions
    render json: { classSessions: workout_sessions,
                   weekdays: Session.weekdays.keys.map(&:titlecase),
                   selectedDays: workout_sessions.map(&:day),
                   selectedTimes: workout_sessions.map { |workout_session| Time.parse("#{workout_session.class_time} #{workout_session.meridiem}").strftime("%H:%M") },
                   selectedDurations: workout_sessions.map(&:duration),
                   selectedSessionIds: workout_sessions.map(&:id)}
  end

  protected

  def workout_class_params
    params.require(:workout_class).permit(:title, :description, :cost, :avatar, :zoom_url, :active)
  end
end