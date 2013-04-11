class AuthenticationsController < Devise::SessionsController
  respond_to :html

  def new
  end

  def create
    @user = User.find_by_email(params[:user][:email])

    if @user && @user.active
      @user.reset_authentication_token!
      UserMailer.signin_token(@user).deliver
      flash[:notice] = I18n.t('login.click_link_in_mail')
    elsif @user && !@user.active
      flash[:error] = I18n.t('login.account_not_yet_active')
    else
      flash[:error] = I18n.t('login.email_unknown')
    end
    
    redirect_to new_user_session_path
  end

end