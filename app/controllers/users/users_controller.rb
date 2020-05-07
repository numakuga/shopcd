class Users::UsersController < ApplicationController

  before_action :user_find

  def show
  end

  def edit
  end

  def exit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "プロフィールを編集しました。"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def user_params
      params.require(:user).permit(:first_name, :last_name, :last_name, :last_kana, :postal_code, :address, :phone, :email)
  end
end
