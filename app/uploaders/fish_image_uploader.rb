class FishImageUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  attr_accessor :latitude, :longitude, :datetime
  if Rails.env.production? || Rails.env.development?
    storage :fog
  else
    storage :file
  end

  # 画像の上限を700pxにする
  # process :resize_to_limit => [700, 700]

  # 保存形式をJPGにする
  # process convert: 'jpg'

  # サムネイルを生成する設定
  # version :thumb do
  #   process :resize_to_limit => [300, 300]
  # end

  # jpg,jpeg,gif,pngしか受け付けない
  # def extension_white_list
    # %w(jpg jpeg gif png)
  # end

  process :get_exif_info
  # # def get_exif_info
  # #   exif = Magick::Image.read(self.file.file).first
  # #   # binding.pry
  # #   # p exif
  # # end
  def get_exif_info
    require 'exifr/jpeg'
    exif = EXIFR::JPEG::new(self.file.file)
    @latitude = EXIFR::JPEG::new(self.file.file).gps.latitude
    @longitude = EXIFR::JPEG::new(self.file.file).gps.longitude
    @datetime = EXIFR::JPEG::new(self.file.file).date_time 
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # キャッシュ先のディレクトリを指定
  # def cache_dir
  #   # "cache"
  # end

  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  # def filename
  #   super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  # end
end