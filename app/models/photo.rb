class Photo < ApplicationRecord
 mount_uploader :photo, PhotoUploader
 belongs_to :product
 validates :product, presence: true

   def to_jq_upload
    {
      "url" => photo.medium.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }.to_json
  end
end

