# == Schema Information
#
# Table name: english_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EnglishType < ApplicationRecord
    has_many :orders
end
