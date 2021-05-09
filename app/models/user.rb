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
  has_many :orders
  has_many :messages

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
    end
  end

end
