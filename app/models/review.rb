# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  message    :string
#  stars      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  user_id    :integer
#
class Review < ApplicationRecord
    has_one :order
    has_one :user

    belongs_to :order
    belongs_to :user

    after_create do
        send_review_emails
    end

    private

    def send_review_emails

        #Email support
        SeMailer.with(order: self.order, review: self, recipient: SEConstants::SUPPORT_EMAIL).delay.user_review

        #Email all admins
        User.includes(:user_settings).where(admin: true).all.each do |admin|
            email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
            if email_updates.first.value == "true"
                SeMailer.with(order: self.order, review: self, recipient: admin.email).delay.user_review
            end
        end
        
    end
end
