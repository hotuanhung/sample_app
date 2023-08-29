class UserMailer < ApplicationMailera
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email.active")
  end
end
