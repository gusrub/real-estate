class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :set_title

  FLASH_TYPES = {
    warning: "warning",
    success: "success",
    danger: "danger",
    info: "info"
  }

  before_action :require_login

  rescue_from StandardError, with: :rescue_standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
  
  attr_accessor :debugging

  def initialize
    @debugging = true
    super
  end

  private
  def require_login
    unless is_logged_in?
      render file: "#{Rails.root}/public/401.html", layout: false, status: :unauthorized
    end
  end

  def set_title
    @page_title = "Real Estate Demo"
  end

  def rescue_standard_error(error)
    @error = error
    STDOUT.write error.message
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/500.html", layout: false, status: :internal_server_error }
      format.json { render json: error.message, status: :internal_server_error  }
      format.xml { render xml: error.message, status: :internal_server_error}
    end
  end

  def rescue_not_found(error)
    @error = error
    STDOUT.write error.message
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found }
      format.json { render json: error.message, status: :not_found  }
      format.xml { render xml: error.message, status: :not_found}
    end
  end

end
