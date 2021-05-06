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

  # todo: fix this repeating db call
  def self.client
    ResourceType.where(name: 'client').first
  end

  # todo: fix this repeating db call
  def self.business
    ResourceType.where(name: 'business').first
  end

end
