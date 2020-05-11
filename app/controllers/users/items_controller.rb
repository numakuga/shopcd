class Users::ItemsController < ApplicationController
  def index
    @items = Item.where(status: true)
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
    @discs = Disk.where(item_id: @item.id)
    @songs = Song.where(disk_id: Disk.find_by(item_id: @item.id))
  end
end
