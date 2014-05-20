class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to edit_users_path, notice: 'Your profile was successfully updated.'
    else
      redirect_to edit_users_path, alert: model_alert(current_user)
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: 'Your account and contacts were successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :default_location_display)
  end

end
