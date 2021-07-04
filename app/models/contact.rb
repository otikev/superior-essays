class Contact
    include ActiveModel::Model

    attr_accessor :name, :email, :message, :subject
    validates :name, :email, :message, :subject, presence: true

    
    def deliver
        if valid?
            User.includes(:user_settings).where(admin: true).all.each do |admin|
                email_updates = admin.user_settings.where(name: SEConstants::UserSettings::EMAIL_UPDATES)
                if email_updates.first.value == "true"
                    SeMailer.with(contact: self, recipient: admin.email).delay.contact_form
                end
            end
            SeMailer.with(contact: self, recipient: "support@superioressays.pro").delay.contact_form
        end
    end
end