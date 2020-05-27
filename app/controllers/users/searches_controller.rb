class Users::SearchesController < ApplicationController

  def items
    @q = Item.ransack(params[:q])
    @items = Item.ransack(ransack_item_params).result
    render "users/items/index"
  end

  def artists

  end

  private

  def ransack_item_params
    params.require(:q).permit(:title_cont)
  end
end
