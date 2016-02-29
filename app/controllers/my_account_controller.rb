class MyAccountController < ApplicationController

  before_action :set_user

  def index
    
  end

  def show

  end

  def update
    if @user.update(user_params)
      flash[:type] = FLASH_TYPES[:success]
      flash[:msg] = "User successfully updated" 
      redirect_to my_account_path
    else
      flash.now[:type] = FLASH_TYPES[:warning]
      flash.now[:msg] = "Please fill in all required information"
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password)
  end

  def set_user
    @user = User.find @current_user.id
  end

end