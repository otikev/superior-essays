# == Schema Information
#
# Table name: paper_formats
#
#  id         :bigint           not null, primary key
#  key        :uuid
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PaperFormat < ApplicationRecord
    has_many :orders
end
