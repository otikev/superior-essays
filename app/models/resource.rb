# == Schema Information
#
# Table name: resources
#
#  id                    :bigint           not null, primary key
#  description           :string
#  file                  :string
#  internal_resource_url :string
#  key                   :uuid
#  name                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  order_id              :integer
#  resource_type_id      :integer          default(1)
#  user_id               :integer
#



class Resource < ApplicationRecord
  require 'utils'

  before_destroy :delete_s3_resource

  has_one :user
  has_one :order
  has_one :resource_type

  belongs_to :order
  belongs_to :user
  belongs_to :resource_type

  def get_file_from_s3
    directory_name = Rails.root.join('public','downloads')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    filename =  Rails.root.join(directory_name, self.file)

    if !File.exists?(filename)
      s3 = Aws::S3::Client.new(region: 'eu-west-1')
      File.open(filename, 'wb') do |file|
        resp = s3.get_object({ response_target: file, bucket: ENV['S3_BUCKET'], key: "resources/#{File.basename(filename)}" })

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

  def self.upload_to_s3(user_id, params)
    uploaded_io = params[:resource][:file]

    upload = Resource.new
    upload.name = uploaded_io.original_filename
    upload.order_id = params[:resource][:order_id]
    upload.resource_type_id = params[:resource][:resource_type_id]

    extension = File.extname(uploaded_io.original_filename)

    directory_name = Rails.root.join('public','uploads')
    Dir.mkdir(directory_name) unless File.exists?(directory_name)

    order = Order.where(id: params[:resource][:order_id]).first
    filename =  Rails.root.join(directory_name, "#{order.code}-#{uploaded_io.original_filename}")

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
    upload.user_id = user_id
    return upload
  end

  private
  def delete_s3_resource
    obj = S3_OBJ.bucket(ENV['S3_BUCKET']).object(self.file)
    if obj
      obj.delete
    end
  end

end
