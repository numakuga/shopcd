class Users::ItemsController < ApplicationController
  def index
    @items = Item.where(status: true)
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
    @discs = Disc.where(item_id: @item.id)
    @songs = Song.where(disk_id: Disc.find_by(item_id: @item.id))
  end
end
