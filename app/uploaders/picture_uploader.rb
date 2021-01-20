class PictureUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "default_tournament.jpg"
  end

  version :thumb do
    process resize_to_fit: [500, 500]
  end

  version :thumbnail do
    process resize_to_fill: [200, 200, "Center"]
  end
end
