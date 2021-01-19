class FishImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # 画像の上限を700pxにする
  process :resize_to_limit => [700, 700]

  # 保存形式をJPGにする
  process convert: 'jpg'

  # サムネイルを生成する設定
  version :thumb do
    process :resize_to_limit => [300, 300]
  end

  # jpg,jpeg,gif,pngしか受け付けない
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :get_exif_info
  def get_exif_info
    exif = Magick::Image.read(self.file.file).first
  end

  def store_dir
    "uploads/post/fish_image"
  end

  # コンバートできるように拡張子をJPGに統一させる
  # def filename
  #   Time.now.strftime('%Y%m%d%H%M%S') + original_filename + '.jpg' if original_filename.present?
  # end

  # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
end