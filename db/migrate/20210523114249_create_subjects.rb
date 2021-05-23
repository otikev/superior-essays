class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name

      t.timestamps
    end

    add_column :orders, :subject_id, :integer

    Subject.new(name: 'Accounting').save!
    Subject.new(name: 'Agriculture').save!
    Subject.new(name: 'Anthropology').save!
    Subject.new(name: 'Application Letters').save!
    Subject.new(name: 'Architecture, Building and Planning').save!
    Subject.new(name: 'Art (Fine arts, Performing arts)').save!
    Subject.new(name: 'Astronomy (and other Space Sciences)').save!
    Subject.new(name: 'Aviation').save!
    Subject.new(name: 'Biology (and other Life Sciences)').save!
    Subject.new(name: 'Business Studies').save!
    Subject.new(name: 'Chemistry').save!
    Subject.new(name: 'Civil Engineering').save!
    Subject.new(name: 'Classic English Literature').save!
    Subject.new(name: 'Communications').save!
    Subject.new(name: 'Composition').save!
    Subject.new(name: 'Computer Science').save!
    Subject.new(name: 'Criminal Justice').save!
    Subject.new(name: 'Criminal Law').save!
    Subject.new(name: 'Cultural and Ethnic Studies').save!
    Subject.new(name: 'Ecology').save!
    Subject.new(name: 'Economics').save!
    Subject.new(name: 'Education').save!
    Subject.new(name: 'Engineering').save!
    Subject.new(name: 'English 101').save!
    Subject.new(name: 'English').save!
    Subject.new(name: 'Environmental Studies and Forestry').save!
    Subject.new(name: 'Ethics').save!
    Subject.new(name: 'Family and Consumer Science').save!
    Subject.new(name: 'Film and Theatre studies').save!
    Subject.new(name: 'Finance').save!
    Subject.new(name: 'Geography').save!
    Subject.new(name: 'Geology and other Earth Sciences').save!
    Subject.new(name: 'Healthcare').save!
    Subject.new(name: 'History').save!
    Subject.new(name: 'Human Resource Management').save!
    Subject.new(name: 'International Relations').save!
    Subject.new(name: 'International Trade').save!
    Subject.new(name: 'IT, Web').save!
    Subject.new(name: 'Law').save!
    Subject.new(name: 'Leadership Studies').save!
    Subject.new(name: 'Linguistics').save!
    Subject.new(name: 'Literature').save!
    Subject.new(name: 'Logistics').save!
    Subject.new(name: 'Management').save!
    Subject.new(name: 'Marketing').save!
    Subject.new(name: 'Mathematics').save!
    Subject.new(name: 'Medical Sciences (Anatomy, Physiology, Pharmacology etc)').save!
    Subject.new(name: 'Medicine').save!
    Subject.new(name: 'Music').save!
    Subject.new(name: 'Nursing').save!
    Subject.new(name: 'Nutrition/Dietary').save!
    Subject.new(name: 'Other').save!
    Subject.new(name: 'Physiology').save!
    Subject.new(name: 'Physics').save!
    Subject.new(name: 'Poetry').save!
    Subject.new(name: 'Political Science').save!
    Subject.new(name: 'Psychology').save!
    Subject.new(name: 'Public Administration').save!
    Subject.new(name: 'Public Relations').save!
    Subject.new(name: 'Religious Studies').save!
    Subject.new(name: 'Shakespeare').save!
    Subject.new(name: 'Social Work and Human Services').save!
    Subject.new(name: 'Sociology').save!
    Subject.new(name: 'Sports').save!
    Subject.new(name: 'Statistics').save!
    Subject.new(name: 'Technology').save!
    Subject.new(name: 'Tourism').save!
    Subject.new(name: 'Urban Studies').save!
    Subject.new(name: 'Women and Gender Studies').save!
    Subject.new(name: 'Zoology').save!
  end
end
