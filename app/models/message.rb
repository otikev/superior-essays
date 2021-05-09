class Message < ApplicationRecord

  has_one :order
  has_one :user

  belongs_to :order
  belongs_to :user

end
