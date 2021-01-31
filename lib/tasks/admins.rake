namespace :admins do
  desc 'Create admin users'
  task setup: :environment do

    kev = User.where(email: "oti.kevin@gmail.com").first
    if kev
      kev.admin = true
      kev.save!
    end


    lucy = User.where(email: "lanzyanna@gmail.com").first
    if lucy
      lucy.admin = true
      lucy.save!
    end

    puts 'Created admin users'
  end

end
