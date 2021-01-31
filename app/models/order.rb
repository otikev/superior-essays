class Order < ApplicationRecord
  require 'utils'
  belongs_to :user

end
