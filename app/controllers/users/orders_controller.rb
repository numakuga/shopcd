class Users::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :barrier_user

  def index
    @orders = current_user.orders.order(updated_at: :desc)
    @handing_cost = 500
  end

  def new
    @order = Order.new
    @addresses = current_user.addresses
    @cart_items = current_user.cart_items.order(updated_at: :desc)
  end

  def confirm
    flash.now[:notice] = "まだ購入は完了していません。"
    @delivery_cost = 500
    @handing_cost  = Order.payments[params[:order][:payment]] == 2 ? 500 : 0
    @order = current_user.orders.new(order_params)

    # 手動でバリデーションチェック
    return if @order.valid?
    @addresses = current_user.addresses
    @cart_items = current_user.cart_items.order(updated_at: :desc)
    render :new
  end

  def create
    @delivery_cost = 500
    @handing_cost  = Order.payments[params[:order][:payment]] == 2 ? 500 : 0
    # 支払い方法選択等に戻る場合
    if params[:back]
      @order = current_user.orders.new(order_params)
      @addresses = current_user.addresses
      @cart_items = current_user.cart_items.order(updated_at: :desc)
      render :new
      return
    end

    current_user.cart_items.each do |cart_item|
      unless cart_item.less_than_stock?
        flash[:notice] = "#{cart_item.item.title}購入点数の在庫がありません。数量をご確認ください。"
        @cart_items = current_user.cart_items.order(updated_at: :desc)
        render "users/cart_items/index"
        return
      end
    end

    # フォームで入力されたパラメータだったらcreate_addressへ遷移
    boolean  = params[:order][:address_num].to_i == 1 ? create_address : true

    if boolean
      @order = current_user.orders.new(order_params)
      if @order.save
        current_user.cart_items.each do |cart_item|
          @order.order_details.create!(
            item_id: cart_item.item_id,
            price: cart_item.item.price,
            piece: cart_item.piece
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
    params.require(:order).permit(:name, :postal_code, :address)
  end

  def create_address
    current_user.addresses.create(address_params)
  end

  def order_params
    case params[:order][:address_num].to_i
    when 0 #ログインユーザー登録住所
      name = current_user.full_name
      postal_code = current_user.postal_code
      address = current_user.address
    when 1 #フォームで入力住所
      # create_addressを使用したいが、confirmで表示させる際にはまだsaveしない為ダメだった
      name = params[:order][:name]
      address = params[:order][:address]
      postal_code = params[:order][:postal_code]
    when 2 #セレクトタグで選択住所
      address_record = Address.find(params[:order][:address_id])
      name = address_record.name
      postal_code = address_record.postal_code
      address = address_record.address
    end
    # ハッシュの形で送らないとあかんみたい
    {
      name: name,
      postal_code: postal_code,
      address: address,
      payment: params[:order][:payment],
      total_price: current_user.cart_total_price + @delivery_cost + @handing_cost,
      delivery_cost: @delivery_cost
    }
  end

  #url直接入力禁止
  def barrier_user
    unless User.find(params[:user_id]).id == current_user.id
      redirect_back(fallback_location: root_path)
    end
  end
end
