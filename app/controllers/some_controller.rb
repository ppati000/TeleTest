class SomeController < ApplicationController

  #Some basic controller for this test application

  def home
  end

  def message
  end

  def send_message_to_all
    TeleNotify::TelegramUser.send_message_to_all(params[:message])
    redirect_to '/'
  end

end
