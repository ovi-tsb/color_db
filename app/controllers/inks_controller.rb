class InksController < ApplicationController
  before_action :set_ink, only: [:show, :edit, :update, :destroy]
  

 
  def index
    # @inks = Ink.where(:inks => {:customer_id => customer_id})
    # @inks = Ink.all

    if current_user  && current_user.try(:type) != 'CustomerUser'
      @filterrific = initialize_filterrific(
        # Ink.joins(:customer).where('customer.id' => :customer_id),
        # Ink.joins(:customer).where('customer.id' => :customer_id),
        
          Ink,
          params[:filterrific],
                select_options: {
                  with_customer_id: Customer.options_for_select,
                  sorted_by: Ink.options_for_sorted_by
                }
        
      ) or return
      @inks = @filterrific.find.page(params[:page])

      respond_to do |format|
        format.html
        format.js
      end
    elsif  current_user  && current_user.try(:type) == 'CustomerUser'
        @filterrific = initialize_filterrific(
        # Ink.joins(:customer).where(:inks => {:customer_id => current_user.id}),
        # Ink.joins(:customer).where("customer.name =?" , current_user.customer_name),
        Ink.joins(:customer).where(:inks => {:customer_id =>current_user.customer_id}),
        params[:filterrific],
              select_options: {
                with_customer_id: Customer.options_for_select,
                sorted_by: Ink.options_for_sorted_by
              }
              ) or return
              @inks = @filterrific.find.page(params[:page])

              respond_to do |format|
                format.html
                format.js
              end
      end        
  end

  def new
    @ink = Ink.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ink.update(ink_params)
        format.html { redirect_to inks_path, notice: 'Ink was successfully updated.' }
        format.json { render :index, status: :ok, location: @ink }
      else
        format.html { render :edit }
        format.json { render json: @ink.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @ink = Ink.new(ink_params)
    @ink.customer_id = params[:customer_id]
    @ink.user_id = current_user.id
    # @group.user_id = current_user.id
    
    # @group.game_id = params[:game_id]
    respond_to do |format|
      if @ink.save
        format.html { redirect_to inks_path, notice: 'Ink was successfully created.' }
        format.json { render :show, status: :created, location: @ink }
      else
        format.html { render :new }
        format.json { render json: @ink.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @ink.destroy
    respond_to do |format|
      format.html { redirect_to inks_path, notice: 'Ink was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ink
      @ink = Ink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ink_params
      params.require(:ink).permit(:name, :ink_type, :client, :substrate, :coating, :ink_number, :sap, :approved, :approved_on, :comments, :customer_id, :modified_by, :user_id)
    end

    def redirect_unless_admin
      unless current_user.try(:admin?)
        flash[:error] = "Only admins can do that"
        redirect_to root_path
      end
    end

    
end













