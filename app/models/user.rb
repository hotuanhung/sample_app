class User < ApplicationRecord
  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX}
  before_save :downcase_email
  has_secure_password
  private
  def downcase_email
    email.downcase!
  end
end
