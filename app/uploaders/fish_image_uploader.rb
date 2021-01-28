class FishImageUploader < CarrierWave::Uploader::Base
  attr_accessor :latitude, :longitude, :datetime

  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  process :get_exif_info
  def get_exif_info
    begin
    require 'exifr/jpeg'
      exif = EXIFR::JPEG::new(self.file.file)
      @latitude = exif.gps.latitude
      @longitude = exif.gps.longitude
      @datetime = exif.date_time
    rescue
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end