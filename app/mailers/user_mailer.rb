class UserMailer < ApplicationMailer
  # アカウント有効化メールを送信するメソッド
  def account_activation(user)
    @user = user
    mail to: @user.email, subject: "Account activation" do |format|
      format.text { render plain: "こんにちは #{@user.name} 様、アカウントを有効化するには以下のリンクをクリックしてください: #{edit_account_activation_url(@user.activation_token, email: CGI.escape(@user.email))}" }
      format.html { render html: "<h1>こんにちは #{@user.name} 様</h1><p>アカウントを有効化するには以下のリンクをクリックしてください:</p><p><a href='#{edit_account_activation_url(@user.activation_token, email: CGI.escape(@user.email))}'>アカウント有効化リンク</a></p>".html_safe }
    end
  end

  # パスワードリセットメールを送信するメソッド
  def password_reset(user)
    @user = user
    @greeting = "こんにちは #{@user.name} 様"
    mail to: @user.email, subject: "Password reset" do |format|
      format.text { render plain: "#{@greeting}、パスワードをリセットするには以下のリンクをクリックしてください: #{edit_password_reset_url(@user.reset_token, email: CGI.escape(@user.email))}" }
      format.html { render html: "<h1>#{@greeting}</h1><p>パスワードをリセットするには以下のリンクをクリックしてください:</p><p><a href='#{edit_password_reset_url(@user.reset_token, email: CGI.escape(@user.email))}'>パスワードリセットリンク</a></p>".html_safe }
    end
  end
end
