class Users::ItemsController < ApplicationController
  def index
    @items = Item.where(status: true)
  end

  def show
  end
end
