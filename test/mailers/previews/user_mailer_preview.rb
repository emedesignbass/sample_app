# test/mailers/user_mailer_test.rb
require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:example_user) # example_user フィクスチャを使用
    @user.activation_token = User.new_token
  end

  test "account activation" do
    mail = UserMailer.account_activation(@user)
    assert_emails 1 do
      mail.deliver_now
    end
    assert_equal "Account activation", mail.subject
    assert_equal [@user.email], mail.to
    assert_match "Example User", mail.body.encoded
  end

  test "password reset" do
    mail = UserMailer.password_reset(@user)
    assert_emails 1 do
      mail.deliver_now
    end
    assert_equal "Password reset", mail.subject
    assert_equal [@user.email], mail.to
    assert_match "パスワードリセット", mail.body.encoded # こちらも内容に合わせて修正
  end
end
