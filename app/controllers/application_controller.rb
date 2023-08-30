class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper
  include Pagy::Backend

  protect_from_forgery with: :exception
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("flash.logged_in")
    store_location
    redirect_to login_url, status: :see_other
  end
end
