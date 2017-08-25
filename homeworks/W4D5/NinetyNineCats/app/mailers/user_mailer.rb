class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_mail(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: "Welcome to my site")
  end
end
