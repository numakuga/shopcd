class Users::OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(updated_at: :desc)
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
    return if @order.valid?
    render :new
  end

  def create
    @delivery_cost = 500
    # フォームで入力されたパラメータだったらcreate_addressへ遷移
    boolean  = params[:address_num].to_i == 1 ? create_address : true

    current_user.cart_items.each do |cart_item|
      unless cart_item.less_than_stock?
        flash[:notice] = "#{cart_item.item.title}購入点数の在庫がありません。数量をご確認ください。"
        @cart_items = current_user.cart_items.order(updated_at: :desc)
        render "users/cart_items/index"
        return
      end
    end

    if boolean
      @order = current_user.orders.new(order_params)
      if @order.save
        current_user.cart_items.each do |cart_item|
          @order.order_details.create!(
            item_id: cart_item.item_id,
            cd_price: cart_item.item.price,
            cd_amount: cart_item.piece
          )
          cart_item.item.reduce_stock(cart_item.piece)
          cart_item.destroy
        end
        redirect_to user_orders_thanks_path(current_user)
      else
        render :confirm
      end
    else
      @order = current_user.orders.new(order_params)
      render :confirm
    end
  end

  def thanks
  end

  private

  def address_params
    params.permit(:name, :postal_code, :address)
  end

  def create_address
    current_user.addresses.create(address_params)
  end

  def order_params
    case params[:address_num].to_i
    when 0 #ログインユーザー登録住所
      name = current_user.full_name
      postal_code = current_user.postal_code
      address = current_user.address
    when 1 #フォームで入力住所
      # create_addressを使用したいが、confirmで表示させる際にはまだsaveしない為ダメだった
      name = params[:name]
      address = params[:address]
      postal_code = params[:postal_code]
    when 2 #セレクトタグで選択住所
      address_record = Address.find(params[:address_id])
      name = address_record.name
      postal_code = address_record.postal_code
      address = address_record.address
    end
    # ハッシュの形で送らないとあかんみたい
    {
      name: name,
      postal_code: postal_code,
      address: address,
      payment: params[:payment],
      total_price: current_user.cart_total_price + @delivery_cost,
      delivery_cost: @delivery_cost
    }
  end
end
