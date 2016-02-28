class MyAccountController < ApplicationController

  before_action :set_user
  before_action :set_title  

  def index
    
  end

  def show

  end

  def update
    if @user.update(user_params)
      flash[:type] = "success"
      flash[:msg] = "Usuario actualizado"
      redirect_to my_account_path
    else
      flash[:type] = "warning"
      flash[:msg] = "Por favor rellena los campos"
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

  def set_title
    @page_title = "User Preferences"
  end  

end