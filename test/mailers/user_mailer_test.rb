require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:example) # ここではユーザーをフィクスチャから取得

    # ユーザーを新しく作成し、有効化ダイジェストを生成
    @user.create_activation_digest
    @user.create_reset_digest # ここでリセットダイジェストを生成
  end

  test "account activation" do
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_match /こんにちは #{@user.name} 様、アカウントを有効化するには以下のリンクをクリックしてください:/, mail.text_part.decoded
    assert_match /アカウントを有効化するには以下のリンクをクリックしてください:/, mail.html_part.decoded
  end

  test "password reset" do
    mail = UserMailer.password_reset(@user)
    assert_equal "Password reset", mail.subject
    assert_match /こんにちは #{@user.name} 様、パスワードをリセットするには以下のリンクをクリックしてください:/, mail.text_part.decoded
    assert_match /パスワードをリセットするには以下のリンクをクリックしてください:/, mail.html_part.decoded
  end
end

