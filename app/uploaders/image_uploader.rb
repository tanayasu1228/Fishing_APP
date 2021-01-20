class ImageUploader < CarrierWave::Uploader::Base
  # リサイズしたり画像形式を変更するのに必要
  include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # 画像の上限を100x100にする
  process resize_to_fit: [400, 400]

  # 保存形式をJPGにする
  process convert: 'jpg'

  def default_url(*args)
    "default_user_image.jpeg"
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :profile_image do
    process resize_to_fit: [80, 80]
  end
end
