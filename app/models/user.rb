# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  admin      :boolean          default(FALSE)
#  email      :string
#  enabled    :boolean          default(TRUE)
#  first_name :string
#  key        :uuid
#  last_name  :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :orders, -> { order(created_at: :desc) }
  has_many :messages, -> { order(created_at: :desc) }
  has_many :indicators, -> { order(created_at: :desc) }
  has_many :reviews
  has_many :user_settings
  has_many :user_vouchers, -> { order(created_at: :desc) }

  after_create do
    UserSetting.generate(self)
  end

  def self.from_omniauth(auth)
    _user = where(email: auth.info.email).first_or_initialize do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
    end
    Indicator.generate_user_signal(SEConstants::Signals::USER_LOGIN,_user)
    _user
  end

end
