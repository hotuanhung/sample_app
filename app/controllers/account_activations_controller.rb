class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit

  def edit
    if !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t("flash.active")
      redirect_to @user
    else
      flash[:danger] = t("flash.active_fail")
      redirect_to root_url
    end
  end

  private

  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t("flash.active_fail")
    redirect_to root_url
  end
end
