class RegistrationsController < Devise::RegistrationsController
  
  before_filter :remove_all_password_references

  def update
    @user = User.find(current_user.id)

    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true # to bypass validation in case his password changed
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  def remove_all_password_references
    # Remove all the password params, as Contractor does not store passwords!
    if params[:user]
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:current_password)
    end
  end

end