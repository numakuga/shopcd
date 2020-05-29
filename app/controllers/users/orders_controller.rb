class Users::OrdersController < ApplicationController
  def index

  end

  def new
    @order = Order.new
    @addresses = current_user.addresses
    @cart_items = current_user.cart_items.order(updated_at: :desc)
  end

  def confirm
    flash.now[:notice] = "まだ購入は完了していません。"
    @delivery_cost = 500
    @order = current_user.orders.new(order_params)
    
  end

  def create

  end

  def thanks
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

  def order_params
    case params[:address_num].to_i
    when 0 #ログインユーザー登録住所
      # @full_name = current_user.first_name + current_user.last_name
      postal_code = current_user.postal_code
      address = current_user.address
    when 1 #フォームで入力住所
      address = params[:address]
      postal_code = params[:postal_code]
    when 2 #セレクトタグで選択住所
      address_record = Address.params[:address_id]
      postal_code = address_record.postal_code
      address = address_record.address
    end
    {
      postal_code: postal_code,
      address: address,
      payment: params[:payment],
      total_price: current_user.cart_total_price + @delivery_cost,
      delivery_cost: @delivery_cost
    }
  end
end
