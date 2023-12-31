class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t("micropost.created")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed, items: Settings.page_10
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t("micropost.delete")
    else
      flash[:danger] = t("micropost.delete_fail")
    end
    redirect_to request.referer || root_url, status: :see_other
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t("micropost.invalid")
    redirect_to root_url, status: :see_other
  end
end
