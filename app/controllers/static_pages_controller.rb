class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build if logged_in?
    @pagy, @feed_items = pagy current_user.feed,
                              items: Settings.page_10
  end

  def help; end

  def about; end

  def contact; end
end
