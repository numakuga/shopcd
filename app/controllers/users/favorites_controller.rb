class Users::FavoritesController < ApplicationController
  def index
  end

  def create
    like = current_user.favorites.create(item_id: params[:item_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = current_user.favorites.find_by(item_id: params[:item_id])
    like.destroy
    redirect_back(fallback_location: root_path)
  end
end
