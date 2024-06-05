class User < ApplicationRecord
  authenticates_with_sorcery!

  include Discard::Model
  default_scope -> { kept }

  has_one_attached :image

  has_many :events
  has_many :comments

  validates :name, presence: true, length: { maximum: 100 }

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w\-\._]+@[\w\-\._]+\.[A-Za-z]+\z/
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX, message: "メールアドレスが正しい形式ではありません" }

  VALID_PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*?\d)[\w]+\z/
  VALID_PASSWORD_MESSAGE_HANKAKU = "パスワードは半角英数字で入力してください"
  VALID_PASSWORD_MESSAGE_MINLENGTH = "パスワードは8文字以上で入力してください"
  VALID_PASSWORD_MESSAGE_MAXLENGTH = "パスワードは16文字以内で入力してください"

  validates :password, confirmation: true, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validate :validate_password

  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  VALID_PHONE_NUMBER_MESSAGE_HAIFUN = "電話番号はハイフン無しで入力してください"
  VALID_PHONE_NUMBER_MESSAGE_HANKAKU = "電話番号は半角数字で入力してください"
  VALID_PHONE_NUMBER_MESSAGE_LENGTH = "電話番号は10桁か11桁で入力してください"
  validate :validate_phone_number
  validates :phone_number, presence: true

  validates :self_introduction, length: { maximum: 255 }

  private

  def validate_password
    if password.present?
      errors.add(:password, VALID_PASSWORD_MESSAGE_HANKAKU) unless password =~ VALID_PASSWORD_REGEX
      errors.add(:password, VALID_PASSWORD_MESSAGE_MINLENGTH) unless password.length >= 8
    errors.add(:password, VALID_PASSWORD_MESSAGE_MAXLENGTH) unless password.length <= 16
    end
  end

  def validate_phone_number
    if phone_number.present?
      errors.add(:phone_number, VALID_PHONE_NUMBER_MESSAGE_HAIFUN) if phone_number.include?('-');
      errors.add(:phone_number, VALID_PHONE_NUMBER_MESSAGE_HANKAKU) unless phone_number =~ /\A\d+\z/
      errors.add(:phone_number, VALID_PHONE_NUMBER_MESSAGE_LENGTH) unless phone_number =~ VALID_PHONE_NUMBER_REGEX
    end
  end
end
