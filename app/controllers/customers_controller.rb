class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_super_admin, only: [:show, :new, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def edit
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @customers = Customer.all
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customers_path, notice: 'Ink was successfully updated.' }
        format.json { render :index, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def authorize_super_admin
      redirect_to root_path, alert: "You are not allow  !!!" unless current_user.try(:type) == 'SuperUser'
      #redirects to previous page
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name)
    end

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end


  def authenticate_admin
    # TODO Add authentication logic here.
    unless current_user.try(:type) == 'SuperUser'
            flash[:alert] = "You are not authorized to access this page."
            redirect_to(root_path)
    end
  end

end
