class Users::ItemsController < ApplicationController
  def index
    @items = Item.where(status: true)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
