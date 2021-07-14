require 'stripe'
class StandAloneStoreController < ApplicationController
	skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  layout 'stand_alone_store'

  def index
    @gym = Gym.find_by(subdomain: params[:gym])
    @title = @gym&.name || "Boomslang Fitness"
    @registered_user_class_details = WorkoutClassRegistration.map_details("#{cookies[:first_name]} #{cookies[:last_name]}")
    @classes = if @gym.workout_classes
      @gym.workout_classes.where(active: true).includes(:sessions, :workout_class_registrations).sort_by(&:title)
    else
      []
    end
  rescue StandardError => error
    flash[:alert] = "Please make sure you have entered the gym name"
	end

  def process_payment
    @gym = Gym.find(params[:gym_id])

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: params[:class_description],
          },
          unit_amount: sprintf("%.2f", params[:class_cost]).gsub('.', ''),
        },
        quantity: 1,
      }],
      mode: 'payment',
      # For now leave these URLs as placeholder values.
      #
      # Later on in the guide, you'll create a real success page, but no need to
      # do it yet.
      success_url: "#{@stripe_url_path}/stand_alone_store/purchase?class_id=#{params[:class_id]}&session_id={CHECKOUT_SESSION_ID}&subdomain=#{@gym.subdomain}&class_day=#{params[:class_day]}&class_time=#{params[:class_time]}",
      cancel_url: "#{@stripe_url_path}/store?gym=#{@gym.subdomain}",
    })


    respond_to do |format|
      format.json { render json: { id: session.id}.to_json }
    end
  end

  def purchase
    @subdomain = params[:subdomain]

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])

    workout_class = WorkoutClass.find(params[:class_id])
    workout_session = workout_class
      .sessions
      .find_by(day: WorkoutGroup.day_of_the_weeks.key(params[:class_day].titleize),
             class_time: params[:class_time].match(/\d:\d+/).to_s,
             meridiem: params[:class_time].match(/[AM|PM]+/).to_s)

    registration = workout_class
      .workout_class_registrations
      .find_or_initialize_by(user_name: "#{cookies[:first_name]} #{cookies[:last_name]}",
                             complete: false,
                             session_id: workout_session.id)

    
    registration.stripe_session_id = params[:session_id] if registration.new_record?

    registration.save!

    flash[:notice] = "Successfully Registered for #{workout_class.title}"
  rescue StandardError => error
    payment_intent_id = @session.payment_intent
    Stripe::Refund.create(payment_intent: payment_intent_id)

    flash[:alert] = "There was an error with creating registration. Payment was cancelled and will not be charged."
  ensure
    redirect_to "#{stand_alone_store_path}?gym=#{@subdomain}"
  end

  def register
    cookies[:first_name] = { :value => params[:user][:first_name] }#, :expires => Time.zone.now.beginning_of_day + 86400}
    cookies[:last_name] = { :value => params[:user][:first_name] }#, :expires => Time.zone.now.beginning_of_day + 86400}
  end
end