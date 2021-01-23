class User < ApplicationRecord
  before_save :downcase_email

  # email
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # password
  has_secure_password
  validates :password, presence: true, allow_nil: true

  private
  def downcase_email
    self.email.downcase!
  end
end
