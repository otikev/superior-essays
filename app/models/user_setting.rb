# == Schema Information
#
# Table name: user_settings
#
#  id         :bigint           not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class UserSetting < ApplicationRecord
    has_one :user

    belongs_to :user
    
    def self.generate(user)
        UserSetting.new(user_id: user.id, name: SEConstants::UserSettings::EMAIL_UPDATES, value: "true").save!
        #New settings added here and an accompanying migration created to add default values for all users
    end

end
