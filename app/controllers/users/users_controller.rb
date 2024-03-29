class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find
  before_action :barrier_user

  def show
  end

  def edit
    @address = Address.new
    @addresses = current_user.addresses
  end

  def exit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "会員情報を編集しました。"
      redirect_to user_path(current_user)
    else
      @address = Address.new
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "ANAGO SHOPEを退会しました。"
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :last_name, :last_kana, :postal_code, :address, :phone, :email)
  end

  #url直接入力禁止
  def barrier_user
    unless @user.id == current_user.id
      redirect_back(fallback_location: root_path)
    end
  end

end
