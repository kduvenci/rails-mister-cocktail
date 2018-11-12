class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  def content_type_whitelist
    /image\//
  end
  
  def store_dir
    'public/my/upload/mr-cocktail/cocktails'
  end
end
