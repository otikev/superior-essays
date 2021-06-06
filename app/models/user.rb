# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  first_name :string
#  last_name  :string
#  email      :string
#  enabled    :boolean          default("true")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key        :uuid
#  admin      :boolean          default("false")
#

class User < ApplicationRecord
  has_many :orders, -> { order(created_at: :desc) }
  has_many :messages, -> { order(created_at: :desc) }
  has_many :indicators, -> { order(created_at: :desc) }

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
