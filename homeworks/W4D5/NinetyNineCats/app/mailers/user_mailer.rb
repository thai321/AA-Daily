class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_mail(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.user_name, subject: "Welcome to my site")
  end
end
