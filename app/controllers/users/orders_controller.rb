class Users::OrdersController < ApplicationController
  def index
    @order = Order.new
    @addresses = Address.where(user_id: current_user.id)
  end

  def new
  end

  def create

  end

  def thanks
  end
end
