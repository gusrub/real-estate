class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @page_title = "Customers List"
    customer_data = Customer::paginate
    set_pagination(customer_data)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @page_title = "Customer Details"
  end

  # GET /customers/new
  def new
    @page_title = "New Customer"
    @customer = Customer.new
    @customer.build_user
  end

  # GET /customers/1/edit
  def edit
    @page_title = "Edit Customer"
  end

  # POST /customers
  # POST /customers.json
  def create
    @page_title = "New Customer"
    @customer = Customer.new(customer_params)
    @customer.user.status = User.statuses[:active]
    @customer.user.role = User.roles[:customer]

    respond_to do |format|
      if @customer.save
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Customer successfully created"          
        format.html { redirect_to @customer}
        format.json { render :show, status: :created, location: @state }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"         
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:type] = FLASH_TYPES[:success]
        flash[:msg] = "Customer successfully updated"        
        format.html { redirect_to @customer }
        format.json { render :show, status: :ok, location: @state }
      else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "Please fill in all required information"             
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    if @customer.destroy
      respond_to do |format|
        flash.now[:type] = FLASH_TYPES[:success]
        flash.now[:msg] = "Customer successfully deleted"
        format.html { redirect_to customers_url }
        format.json { head :no_content }
      end
    else
        flash.now[:type] = FLASH_TYPES[:warning]
        flash.now[:msg] = "There was a problem trying to delete the customer"     
        format.html { render :index }
        format.json { render json: @customer.errors, status: :unprocessable_entity }      
    end
  end

  def search 
    current_page = params[:page]
    search_criteria = params[:search_criteria]
    customer_data = Customer.search(search_criteria, current_page)
    set_pagination(customer_data)
    flash.now[:search_criteria] = params[:search_criteria]

    if customer_data[:total_record_count] > 0
      flash.now[:type] = FLASH_TYPES[:info]
      flash.now[:msg] = "#{customer_data[:total_record_count]} results found"
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
    customer_data = Customer.paginate(current_page)
    set_pagination(customer_data)

    respond_to  do |format| 
      format.html { render :index }
      format.json { head :no_content }
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:title, :phone, :mobile, :user_id, user_attributes: [:id, :first_name, :last_name, :email, :password])
    end

    def set_pagination(customer_data)
      @customers = customer_data[:records]
      @total_record_count = customer_data[:total_record_count]
      @pages = customer_data[:pages]
      @current_record_count = customer_data[:current_record_count]
    end     
end
