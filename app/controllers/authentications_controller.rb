class AuthenticationsController < ApplicationController
  respond_to :html

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user && @user.active
      @user.reset_authentication_token!
      UserMailer.signin_token(@user).deliver

      flash[:notice] = "Bitte schau in deine Emails und clicke auf den Link, um Dich einzuloggen!"
    else
      if @user
        flash[:error] = "Dein Account ist noch nicht aktiv - bitte wende Dich an Deinen Admin."
      else
        flash[:error] = "Unter dieser Email existiert kein User - hast Du Dich vertippt?"
      end
    end
    
    redirect_to new_user_session_path
  end

end