class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #IMPORTANT! THESE TWO LINES MUST COME AFTER protect_from_forgery!
  skip_before_filter :verify_authenticity_token, :only => :webhook
  include TeleNotify::Controller
end
