# == Schema Information
#
# Table name: resource_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResourceType < ApplicationRecord
  has_many :resources
end
