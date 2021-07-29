class RenameUniversityAcademicLevel < ActiveRecord::Migration[6.1]
  def change
    level = AcademicLevel.where(name: 'University').first
    level.name = 'Undergraduate'
    level.save
  end
end
