class CreateUserSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.string :name
      t.string :value

      t.timestamps
    end

    User.all.each do |user|
      UserSetting.generate(user)
    end
  end
end
