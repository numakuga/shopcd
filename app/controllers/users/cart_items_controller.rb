class Users::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :barrier_user

  def index
    @cart_items = current_user.cart_items.order(updated_at: :desc)
    # order：eachの配列をupdateの降順
  end

  def create
    cart_items = current_user.cart_items
    have_item = false
    cart_items.each do |cart_item|
      # カートに同じアイテムがある場合
      if cart_item.item_id == params[:cart_item][:item_id].to_i
        have_item = true
        cart_item.update(
          piece: cart_item.piece + params[:cart_item][:piece].to_i
        )
      end
    end
    # カートに同じアイテムがない場合
    if !have_item
      CartItem.create(cart_item_params)
    end
    redirect_to user_cart_items_path(current_user)
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      flash[:notice] = "#{cart_item.item.title}の個数を変更しました。"
      redirect_back(fallback_location: root_path)
    else
      @cart_items = current_user.cart_items.order(updated_at: :desc)
      render "index"
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "#{cart_item.item.title}を削除しました。"
      redirect_to user_cart_items_path(current_user)
    else
      @cart_items = current_user.cart_items.group(:item_id).order(updated_at: :desc)
      render "index"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:piece, :item_id).merge(user_id: current_user.id)
  end

  #url直接入力禁止
  def barrier_user
    unless User.find(params[:user_id]).id == current_user.id
      redirect_back(fallback_location: root_path)
    end
  end

end
