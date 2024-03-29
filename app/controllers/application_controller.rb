class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  # resource_or_scopeはログインユーザー情報の値がパラメーターで送られてくる
  def after_sign_in_path_for(resource_or_scope) #ログイン後
    if resource_or_scope.is_a?(User) #パラメーターの先頭
      root_path
    else
      # admin
    end
  end

  # resource_or_scopeには:userか:adminが入っている
  def after_sign_out_path_for(resource_or_scope) #ログアウト後
    if resource_or_scope == :user
      root_path
    else
      # admin
    end
  end

  protected

  def configure_permitted_parameters
    add_attrs = [:first_name, :last_name, :first_kana, :last_kana, :address, :postal_code, :phone]
    devise_parameter_sanitizer.permit :sign_up, keys: add_attrs
  end

end
