class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.page_30
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("flash.info")
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:update_sucess] = t("flash.update_succ")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("flash.user_delete")
      redirect_to users_url, status: :see_other
    else
      flash[:danger] = t("flash.user_delete_fail")
      redirect_to users_url, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("flash.logged_in")
    store_location
    redirect_to login_url, status: :see_other
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t("flash.not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t("flash.wrong_user")
    redirect_to root_url, status: :see_other
  end

  def admin_user
    return if current_user.admin?

    flash[:alert] = t("flash.not_admin")
    redirect_to(root_url, status: :see_other)
  end
end
