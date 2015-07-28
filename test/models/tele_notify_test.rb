require 'tele_notify'
require 'minitest/autorun'

class TeleNotifyTest < ActiveSupport::TestCase

  def setup
    @user1 = TeleNotify::TelegramUser.new(telegram_id: 12345678, first_name: "Peter")
    @user1.save
  end

  test "Valid users should be accepted" do
    assert TeleNotify::TelegramUser.new(telegram_id: 11111111, first_name: "Peter").save
    assert TeleNotify::TelegramUser.new(telegram_id: 22222222, first_name: "Shaw").save
  end

  test "Invalid users should be rejected" do
    assert_not TeleNotify::TelegramUser.new(telegram_id: 12345678, first_name: "Peter").save
    assert_not TeleNotify::TelegramUser.new(telegram_id: 12345678, first_name: "Shaw").save
  end

  test "configure_token should work with valid tokens" do
    valid_tokens = ["66381462:AAG1q2brO6DcXnmmn70HwBMw9ReYhS-bF8Y", "119328241:AAEI6EiFCx2ejot_3lxGZr1LuZo304VSrmY"]
    valid_tokens.each do |t|
      assert(TeleNotify::TelegramUser.configure_token(t), "Token " + t.inspect + " is valid but was rejected.")
    end
  end

  test "configure_token should reject invalid tokens" do
    invalid_tokens = ["66381462AAG1q2brO6DcXnmmn70HwBMw9ReYhS-bF8Y", "A119328241:AAEI6EiFCx2ejot_3lxGZr1LuZo304VSrmY", "lol this is certainly not a token", "66381462:AAG1q2brO6DcXnmmn.70HwBMw9ReYhS-bF8Y"]
    invalid_tokens.each do |t|
      assert_raise RuntimeError do
        TeleNotify::TelegramUser.configure_token(t)
      end
    end
  end

end
