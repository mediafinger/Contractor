class AuthenticationsController < Devise::SessionsController
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
    #TODO: use after_sign_in_path(...)
  end


  private

      # If the resource root path is not defined, root_path is used. However,
      # if this default is not enough, you can customize it, for example:
      #
      #   def after_sign_in_path_for(resource)
      #     stored_location_for(resource) ||
      #       if resource.is_a?(User) && resource.can_publish?
      #         publisher_url
      #       else
      #         super
      #       end
      #   end
      #
      
      # def after_sign_in_path_for(resource_or_scope)
      #   stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
      # end

end