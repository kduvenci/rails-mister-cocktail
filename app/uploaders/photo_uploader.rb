class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  def content_type_whitelist
    /image\//
  end

  def public_id
    "mr-cocktail/#{Cloudinary::Utils.random_public_id}"
  end
end
