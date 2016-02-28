class DashboardController < ApplicationController

  before_action :set_title

  def initialize
    @page_title = "Resúmen de actividades"
    super
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: unsupported_format_response(:json), status: :not_acceptable }
      format.xml { render xml: unsupported_format_response(:xml), status: :not_acceptable }
    end
  end

  private

  def set_title
    @page_title = "Dashboard"
  end

end