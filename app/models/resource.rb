# == Schema Information
#
# Table name: resources
#
#  id                    :integer          not null, primary key
#  order_id              :integer
#  resource_type_id      :integer          default("1")
#  name                  :string
#  internal_resource_url :string
#  description           :string
#  file                  :string
#  key                   :uuid
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#



class Resource < ApplicationRecord
  require 'utils'

  has_one :order
  has_one :resource_type

  belongs_to :order
  belongs_to :resource_type

  def get_file_from_s3(user)
    directory_name = Rails.root.join('public','downloads')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    filename =  Rails.root.join(directory_name, self.file)

    if !File.exists?(filename)
      s3 = Aws::S3::Client.new(region: 'eu-west-1')
      File.open(filename, 'wb') do |file|
        resp = s3.get_object({ response_target: file,
                        bucket: ENV['S3_BUCKET'],
                        key: "resources/#{File.basename(filename)}" })

        unless resp.present?
          puts "File #{self.file} doesnt exist on Amazon S3"
        end
      end
    end

    filename
  end

  def self.create_resource(params)
    resource = Resource.new
    resource.name = params[:resource][:name]
    resource.description = params[:resource][:description]
    resource.order_id = params[:resource][:order_id]
    resource.resource_type_id = params[:resource][:resource_type_id]

    resource
  end

  def self.upload_to_s3(params)
    uploaded_io = params[:resource][:file]

    upload = Resource.new
    upload.name = params[:resource][:name]
    upload.description = params[:resource][:description]
    upload.order_id = params[:resource][:order_id]
    upload.resource_type_id = params[:resource][:resource_type_id]

    extension = File.extname(uploaded_io.original_filename)

    directory_name = Rails.root.join('public','uploads')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)

    filename =  Rails.root.join(directory_name, "#{Time.now.to_i}-#{Utils.random_upcase_string(5)}#{extension}")

    File.open(filename, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    key = File.basename(filename)
    obj = S3_OBJ.bucket(ENV['S3_BUCKET']).object("resources/#{key}")
    obj.upload_file(filename)

    puts "************** File uploaded to #{obj.public_url}"

    FileUtils.rm(filename) #delete temporary file

    upload.file = key
    upload.internal_resource_url = obj.public_url
    return upload
  end

  private

  def delete_s3_resource
    if !resource_used_by_others?
      obj = S3_OBJ.bucket(ENV['S3_BUCKET']).object(self.file)
      if obj
        obj.delete
      end
    end
  end

end
