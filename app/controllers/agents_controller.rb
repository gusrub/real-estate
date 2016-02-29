class AgentsController < ApplicationController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /agents
  # GET /agents.json
  def index
    @page_title = "Agents List"
    agent_data = Agent::paginate
    set_pagination(agent_data)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @agents, status: :ok }
      format.csv { send_data Agent.to_csv, filename: "agents-#{Date.today}.csv" }
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text(Agent.to_csv)
        pdf.render_file(Rails.root.join('tmp', "agents-#{Date.today}.pdf"))
        send_file Rails.root.join('tmp', "agents-#{Date.today}.pdf")
      end      
    end     
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    @page_title = "Agent Details"
  end

  # GET /agents/new
  def new
    @page_title = "New Agent"
    @agent = Agent.new
    @agent.build_user
  end

  # GET /agents/1/edit
  def edit
    @page_title = "Edit Agent"
  end

  # POST /agents
  # POST /agents.json
  def create
    @page_title = "New Agent"
    @agent = Agent.new(agent_params)
    @agent.user.status = User.statuses[:active]
    @agent.user.role = User.roles[:agent]

    respond_to do |format|
      if @agent.save
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Agent successfully created"          
        format.html { redirect_to @agent}
        format.json { render :show, status: :created, location: @agent }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"         
        format.html { render :new }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agents/1
  # PATCH/PUT /agents/1.json
  def update
    respond_to do |format|
      if @agent.update(agent_params)
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Agent successfully updated"        
        format.html { redirect_to @agent }
        format.json { render :show, status: :ok, location: @agent }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"             
        format.html { render :edit }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    if @agent.destroy
      respond_to do |format|
        flash.now[:type] = FLASH_TYPES[:success]
        flash.now[:msg] = "Agent successfully deleted"
        format.html { redirect_to agents_url }
        format.json { head :no_content }
      end
    else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "There was a problem trying to delete the agent"     
        format.html { render :index }
        format.json { render json: @agent.errors, status: :unprocessable_entity }      
    end
  end

  def search 
    current_page = params[:page]
    search_criteria = params[:search_criteria]
    agent_data = Agent.search(search_criteria, current_page)
    set_pagination(agent_data)
    flash.now[:search_criteria] = params[:search_criteria]

    if agent_data[:total_record_count] > 0
      flash.now[:type] = FLASH_TYPES[:info]
      flash.now[:msg] = "#{agent_data[:total_record_count]} results found"
    else
      flash.now[:type] = FLASH_TYPES[:warning]
      flash.now[:msg] = "No records found matching your criteria"
    end


    respond_to  do |format| 
      format.html { render :index }
      format.json { head :no_content }
    end
  end

  def paginate
    current_page = params[:page]
    agent_data = Agent.paginate(current_page)
    set_pagination(agent_data)

    respond_to  do |format| 
      format.html { render :index }
      format.json { head :no_content }
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agent_params
      params.require(:agent).permit(:comission, :phone, :mobile, :user_id, user_attributes: [:id, :first_name, :last_name, :email, :password])
    end

    def set_pagination(agent_data)
      @agents = agent_data[:records]
      @total_record_count = agent_data[:total_record_count]
      @pages = agent_data[:pages]
      @current_record_count = agent_data[:current_record_count]
    end      
end
