class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  # GET /states
  # GET /states.json
  def index
    @page_title = "States List"
    state_data = State::paginate
    set_pagination(state_data)
  end

  # GET /states/1
  # GET /states/1.json
  def show
    @page_title = "State Details"
  end

  # GET /states/new
  def new
    @page_title = "New State"
    @state = State.new
  end

  # GET /states/1/edit
  def edit
    @page_title = "Edit State"
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "State successfully created"          
        format.html { redirect_to @state}
        format.json { render :show, status: :created, location: @state }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"         
        format.html { render :new }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "State successfully updated"        
        format.html { redirect_to @state }
        format.json { render :show, status: :ok, location: @state }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"             
        format.html { render :edit }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    if @state.destroy
      respond_to do |format|
        flash.now[:type] = FLASH_TYPES[:success]
        flash.now[:msg] = "State successfully deleted"
        format.html { redirect_to states_url }
        format.json { head :no_content }
      end
    else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "There was a problem trying to delete the state"     
        format.html { render :index }
        format.json { render json: @state.errors, status: :unprocessable_entity }      
    end
  end

  def search 
    current_page = params[:page]
    search_criteria = params[:search_criteria]
    state_data = State.search(search_criteria, current_page)
    set_pagination(state_data)
    flash.now[:search_criteria] = params[:search_criteria]

    if state_data[:total_record_count] > 0
      flash.now[:type] = FLASH_TYPES[:info]
      flash.now[:msg] = "#{state_data[:total_record_count]} results found"
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
    state_data = State.paginate(current_page)
    set_pagination(state_data)

    respond_to  do |format| 
      format.html { render :index }
      format.json { head :no_content }
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name, :code)
    end

    def set_pagination(state_data)
      @states = state_data[:records]
      @total_record_count = state_data[:total_record_count]
      @pages = state_data[:pages]
      @current_record_count = state_data[:current_record_count]
    end     
end
