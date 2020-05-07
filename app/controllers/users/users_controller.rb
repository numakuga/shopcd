class Users::UsersController < ApplicationController
  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def exit
  end

  def update
  end

  def destroy
  end
end
