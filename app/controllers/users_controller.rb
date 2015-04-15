class UsersController < ApplicationController
  def show
    @userwikis = current_user.wikis
  end
end
