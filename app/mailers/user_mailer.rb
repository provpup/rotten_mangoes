class UserMailer < ActionMailer::Base
  default from: "admin@rottenmangoes.com"

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: "Goodbye from Rotten Mangoes")
  end
end
