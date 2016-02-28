class ReportsController < ApplicationController

  before_action :set_title

  def index
    
  end

  private

  def set_title
    @page_title = "System Reports"
  end

end