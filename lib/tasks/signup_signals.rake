namespace :indicators do
    desc 'Generate user signup signals'
    task signup: :environment do

        Indicator.where(:signal_id => SEConstants::Signals::USER_SIGNUP).destroy_all

        User.all.each do |u|
            indicator = Indicator.create(signal_id: SEConstants::Signals::USER_SIGNUP, user_id: u.id)
            indicator.created_at = u.created_at
            indicator.save!
        end
  
      puts 'Created Signup signals for all users'
    end
  end
  