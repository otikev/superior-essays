# == Schema Information
#
# Table name: academic_levels
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AcademicLevel < ApplicationRecord
    has_many :orders
end
