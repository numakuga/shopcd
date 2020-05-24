class Users::OrdersController < ApplicationController
  def index
    @order = Order.new
    @addresses = current_user.addresses
    @cart_items = current_user.cart_items
  end

  def new
  end

  def create

  end

  def thanks
  end
end
