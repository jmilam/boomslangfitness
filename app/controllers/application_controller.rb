class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_stripe_urls
  protect_from_forgery with: :null_session

  def set_stripe_urls
    @stripe_url_path = Rails.env == "production" ? "http://www.boomslangfitness.com" : "http://localhost:3000"
  end
end
