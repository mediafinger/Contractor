class UserMailer < ActionMailer::Base
  default from: "info@onosono.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #

  def activation_confirmation(user)
    @token = user.authentication_token
    @link = "http://localhost:3000/projects/?authentication_token=#{user.authentication_token}"
    @greeting = "Thank you for choosing Contractor"
    @name = user.name

    mail to: user.email
  end

  def signin_token(user)
    @token = user.authentication_token
    @link = "http://localhost:3000/projects/?authentication_token=#{user.authentication_token}"
    
    @greeting = "Thank you for using Contractor!"
    @name = user.name

    mail to: user.email
  end

  def signup_confirmation(user)
    @greeting = "Thanks for signing up to Contractor"
    @name = user.name

    mail to: user.email
  end
end
