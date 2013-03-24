class AuthenticationsController < ApplicationController
  respond_to :html

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user
      @user.reset_authentication_token!                     # a devise helper
      
      flash[:notice] = "http://localhost:3000/projects/?authentication_token=#{@user.authentication_token}"  #TODO: send via email
      redirect_to authentication_path
    else
      flash[:error] = "Unter dieser Email existiert kein User - bitte registrieren Sie sich zuerst."
      redirect_to new_user_registration_path
    end
  end
end