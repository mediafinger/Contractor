class UserMailer < ActionMailer::Base
  default from: "info@onosono.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #

  def activation_confirmation(user)
    user_login_link(user)

    @greeting = "Thank you for choosing Contractor"
    @name = user.name

    mail to: user.email
  end

  def signin_token(user)
    user_login_link(user)
    
    @greeting = "Thank you for using Contractor"
    @name = user.name

    mail to: user.email
  end

  def signup_confirmation(user)
    @greeting = "Thanks for signing up to Contractor"
    @name = user.name

    mail to: user.email
  end


  private

    def user_login_link(user)
      token     = user.authentication_token
      base_url  = Contractor::Application.config.base_url
      path      = "projects/"

      @link = "#{base_url}#{path}?authentication_token=#{token}"
    end

end
