# == Schema Information
#
# Table name: paper_formats
#
#  id         :integer          not null, primary key
#  name       :string
#  key        :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PaperFormat < ApplicationRecord
    has_many :orders
end
