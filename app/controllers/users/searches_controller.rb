class Users::SearchesController < ApplicationController

  def items
    @q = Item.ransack(ransack_item_params)
    @items = @q.result
    render "users/items/index"
  end

  private

  def ransack_item_params
    params.require(:q).permit(:title_or_artist_name_cont)
  end
end
