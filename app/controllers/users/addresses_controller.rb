class Users::AddressesController < ApplicationController

  def create
    @user = current_user
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      redirect_back(fallback_location: edit_user_path(current_user))
    else
      render "users/users/edit"
    end
  end

  def update

  end

  def destroy

  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
