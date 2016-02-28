class SessionsController < ApplicationController

  skip_before_filter :require_login

  def index
    respond_to do |format|
      format.html do
        if is_logged_in?
          redirect_to dashboard_path
        else
          render :index, layout: false
        end
      end

      format.json { render json: unsupported_format_response(:json), status: :not_acceptable }
      format.xml { render xml: unsupported_format_response(:xml), status: :not_acceptable }
    end
  end

  def forgot_password
    respond_to do |format|
      format.html { render :forgot_password, layout: false }
      format.json { render json: unsupported_format_response(:json), status: :not_acceptable }
      format.xml { render xml: unsupported_format_response(:xml), status: :not_acceptable }
    end
  end

  def create
    if user = User.is_valid_login?(params[:username], params[:password])
      #Save some session data
      login(user)
    else
      flash.now[:type] = FLASH_TYPES[:warning]
      flash.now[:msg] = "Wrong username or password"
    end

    respond_to do |format|
      format.html do
        if user
          redirect_to dashboard_path
        else
          render :index, layout: false
        end
      end
      format.json { render json: unsupported_format_response(:json), status: :not_acceptable }
      format.xml { render xml: unsupported_format_response(:xml), status: :not_acceptable }
    end
  end

  def destroy
    respond_to do |format|
      format.html do
        logout
        redirect_to login_path
      end
      format.json { render json: unsupported_format_response(:json), status: :not_acceptable }
      format.xml { render xml: unsupported_format_response(:xml), status: :not_acceptable }
    end
  end

end