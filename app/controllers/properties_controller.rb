class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy, :add_customer, :remove_customer]
  before_action :load_states, only: [:show, :edit, :new, :create, :update, :add_customer, :remove_customer]
  before_action :load_agents, only: [:show, :edit, :new, :create, :update, :add_customer, :remove_customer]
  before_action :load_customers, only: [:show, :edit, :new, :create, :update, :add_customer, :remove_customer]
  before_action :upload_photo, only: [:create, :update]

  # GET /properties
  # GET /properties.json
  def index
    @page_title = "Property List"
    property_data = Property::paginate
    set_pagination(property_data)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @properties, status: :ok }
      format.csv { send_data Property.to_csv, filename: "properties-#{Date.today}.csv" }
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text(Property.to_csv)
        pdf.render_file(Rails.root.join('tmp', "properties-#{Date.today}.pdf"))
        send_file Rails.root.join('tmp', "properties-#{Date.today}.pdf")
      end
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @page_title = "Property Details"
  end

  # GET /properties/new
  def new
    @page_title = "New Property"
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
    @page_title = "Edit Property"
  end

  # POST /properties
  # POST /properties.json
  def create
    @page_title = "New Property"
    @property = Property.new(property_params)
    respond_to do |format|
      if @property.save
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Property successfully created"       
        format.html { redirect_to @property }
        format.json { render :show, status: :created, location: @property }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"         
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Property successfully updated"          
        format.html { redirect_to @property}
        format.json { render :show, status: :ok, location: @property }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"     
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    if @property.destroy
      respond_to do |format|
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Property successfully deleted"
        format.html { redirect_to properties_url }
        format.json { head :no_content }
      end
    else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "There was a problem trying to delete the property"     
        format.html { render :index }
        format.json { render json: @property.errors, status: :unprocessable_entity }      
    end
  end

  def search 
    current_page = params[:page]
    search_criteria = params[:search_criteria]
    property_data = Property.search(search_criteria, current_page)
    set_pagination(property_data)
    flash.now[:search_criteria] = params[:search_criteria]

    if property_data[:total_record_count] > 0
      flash.now[:type] = FLASH_TYPES[:info]
      flash.now[:msg] = "#{property_data[:total_record_count]} results found"
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
    property_data = Property.paginate(current_page)
    set_pagination(property_data)

    respond_to  do |format| 
      format.html { render :index }
      format.json { head :no_content }
    end   
  end

  def add_customer
    if params[:customer_id]
      @property.customers << Customer.find(params[:customer_id])
      flash[:type] = FLASH_TYPES[:info]
      flash[:msg] = "Customer successfully added"
    else
      flash.now[:type] = FLASH_TYPES[:warning]
      flash.now[:msg] = "No customer selected"
    end


    respond_to  do |format| 
      format.html { redirect_to @property }
      format.json { head :no_content }
    end    
  end

  def remove_customer
    if params[:customer_id]
      @property.customer_properties.where(customer_id: params[:customer_id]).first.destroy
      flash[:type] = FLASH_TYPES[:info]
      flash[:msg] = "Customer successfully removed"
    else
      flash.now[:type] = FLASH_TYPES[:warning]
      flash.now[:msg] = "No customer selected"
    end


    respond_to  do |format| 
      format.html { redirect_to @property }
      format.json { head :no_content }
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:title, :description, :photo, :price, :street_number, :street_name, :suite, :zipcode, :city, :state_id, :agent_id, :status)
    end

    def set_pagination(property_data)
      @properties = property_data[:records]
      @total_record_count = property_data[:total_record_count]
      @pages = property_data[:pages]
      @current_record_count = property_data[:current_record_count]
    end  

    def load_states
      @states = State.all
    end

    def load_agents
      @agents = Agent.all
    end

    def load_customers
      if @property
        @leads = Customer.joins(:user).where.not(id: Property.find(params[:id]).customers.ids).pluck("CONCAT(users.first_name,' ' ,users.last_name)", "customers.id")
        @customers = Customer.joins(:user).where(id: Property.find(params[:id]).customers.ids).pluck("CONCAT(users.first_name,' ' ,users.last_name)", "customers.id")
      else
        @leads = Customer.joins(:user).pluck("CONCAT(users.first_name,' ' ,users.last_name)", "customers.id")
        @customers = []
      end
    end

    def upload_photo
      uploaded_io = params[:property][:photo_file]
      return unless uploaded_io
      begin
        photo_filename = "#{SecureRandom::uuid}#{File::extname(uploaded_io.original_filename)}"
        File.open(Rails.root.join('tmp', photo_filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        @property.photo = photo_filename
      rescue StandardError => e
        raise StandardError.new "There was an internal error trying to upload the photo: #{e.message}"
      end

    end      
end
