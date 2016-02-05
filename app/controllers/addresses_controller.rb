class AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.create(whitelisted_address_params)
    if @address.save
      flash[:success] = "Address successfully created"
      redirect_to address_path(@address)
    else
      render :new
    end
  end

  def show
    @address = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(whitelisted_address_params)
      flash[:success] = "Address successfully updated"
      redirect_to address_path(@address)
    else
      render :edit
    end
  end    


  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
      flash[:success] = "Address successfully deleted"
    else
      flash[:error] = "Unable to delete address"
    end
    redirect_to addresses_path
  end



  def whitelisted_address_params
    params.require(:address).permit(:street_address, :secondary_address, :zip_code)
  end


end
