class Users::OrdersController < ApplicationController
  def index

  end

  def new
    @order = Order.new
    @addresses = current_user.addresses
    @cart_items = current_user.cart_items.order(updated_at: :desc)
  end

  def confirm
    @payment = params[:payment]
  end

  def create

  end

  def thanks
  end
end
