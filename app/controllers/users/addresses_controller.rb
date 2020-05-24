class Users::AddressesController < ApplicationController

  def create
    address = Address.new(address_params)
    if address.save
      flash[:notice] = "#{address.name}様の配送先情報を登録しました。"
      redirect_to edit_user_path(current_user)
    else
      @addresses = current_user.addresses
      render "users/users/edit"
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      flash[:notice] = "#{address.name}様の配送先情報を編集しました。"
      redirect_to edit_user_path(current_user)
    else
      @addresses = current_user.addresses
      render "users/users/edit"
    end
  end

  def destroy
    address = Address.find(params[:id])
    if address.destroy
      flash[:notice] = "#{address.name}様の配送先情報を削除しました。"
      redirect_to edit_user_path(current_user)
    else
      @addresses = current_user.addresses
      render "users/users/edit"
    end
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address).merge(user_id: current_user.id)
  end
end
