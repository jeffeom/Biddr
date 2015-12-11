class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
    if user_signed_in? && @user == current_user
        @user = User.find params[:id]
        @bids = @user.bids
    else
        redirect_to root_path, alert: "You are not allowed!"
    end
  end
end
