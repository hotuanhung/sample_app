class Micropost < ApplicationRecord
  has_one_attached :image

  scope :recent_posts, ->{order created_at: :desc}

  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost.content.length.max}
  validates :image, content_type: {in: Settings.model.image_type,
                                   message: I18n.t("image.mess1")},
                    size: {less_than: 5.megabytes,
                           message: I18n.t("image.mess2")}

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :gravatar_for, to: :user

  def display_image
    image.variant resize_to_limit: [500, 500]
  end
end
