class AddContentTypeToContent < ActiveRecord::Migration[6.1]
  def change
    add_column :contents, :content_type, :integer

    Content.all.each do |c|
      c.update_attribute(:content_type, 1)
    end
  end
end
