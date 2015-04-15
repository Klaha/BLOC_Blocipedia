class UsersController < ApplicationController
  def show
    @userwikis = current_user.wikis
  end

  def update
   if current_user.update_attributes(user_params)
     flash[:notice] = "User information updated"
     redirect_to edit_user_registration_path
   else
     flash[:error] = "Invalid user information"
     redirect_to edit_user_registration_path
   end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
