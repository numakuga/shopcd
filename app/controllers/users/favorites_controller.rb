class Users::FavoritesController < ApplicationController
  before_action :set_item, except: [:index]

  def index
    @favorites = current_user.favorites.order(updated_at: :desc)
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
