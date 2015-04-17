class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @userwikis = current_user.wikis
    @userprivatewikis = @userwikis.where('private == ?', true)
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

  def downgrade
    @user = current_user
    @userwikis = current_user.wikis
    @userprivatewikis = @userwikis.where('private == ?', true)
    current_user.downgrade_account

    @userprivatewikis.each do |privatewiki|
      privatewiki.downgrade_wikis
    end

    flash[:notice] = "Account Downgraded"
    redirect_to edit_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
