class Users::FavoritesController < ApplicationController
  before_action :set_item

  def index
  end

  def create
    current_user.favorites.create(item_id: @item.id)
    render "ajax"
  end

  def destroy
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
    render "ajax"
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
