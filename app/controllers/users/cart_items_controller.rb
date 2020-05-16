class Users::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.where(user_id: current_user.id).group(:item_id)
  end

  def create
    # CartItem.new(cart_item_params.merge(user_id: current_user.id))でもok
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to user_cart_items_path(current_user)
    else
      flash[:notice] = "カート内に保存できませんでした。"
      @item = Item.find(params[:cart_item][:item_id])
      render "users/items/show"
    end
  end

  def update

  end

  def destroy

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:piece, :item_id).merge(user_id: current_user.id)
  end
end
