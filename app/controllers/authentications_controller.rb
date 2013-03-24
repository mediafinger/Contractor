class AuthenticationsController < ApplicationController
  respond_to :html

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.reset_authentication_token!                     # a devise helper
      UserMailer.signin_token(@user).deliver

      flash[:notice] = "Bitte schau in deine Emails und clicke auf den Link, um Dich einzuloggen!"
      redirect_to new_user_session_path
    else
      flash[:error] = "Unter dieser Email existiert kein User - bitte registrieren Sie sich zuerst."
      redirect_to new_user_registration_path
    end
  end
end