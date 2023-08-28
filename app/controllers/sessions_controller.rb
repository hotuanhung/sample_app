class SessionsController < ApplicationController
  before_action :find_user, only: %i(create)

  def new; end

  def create
    if @user&.authenticate(params[:session][:password])
      if @user.activated
        handle_if_authenticated @user
      else
        flash[:warning] = t("flash.not_activated")
        redirect_to root_url
      end
    else
      flash.now[:danger] = t("flash.danger")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def handle_if_authenticated user
    reset_session
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    log_in user
    redirect_back_or user
  end

  def find_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
