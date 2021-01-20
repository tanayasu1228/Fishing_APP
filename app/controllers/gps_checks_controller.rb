class GpsChecksController < ApplicationController

  def new
    @gps_check = GpsCheck.new
  end

  def create
    @gps_check = GpsCheck.new(gps_check_params)
    img = Magick::ImageList.new(Rails.root.to_s + "/public/uploads/tmp/#{@post.fish_image}")
    get_exif = img.get_exif_by_entry('GPSLatitude')
    if get_exif[0][1].nil?
      redirect_to new_gps_check_path, alert: "チェック結果： GPSデータがありません。カメラの位置情報設定を変更してください"
    else
      redirect_to new_gps_check_path, notice: "チェック結果： 写真からGPSデータを確認されました。投稿ができる状態です" 
    end
  end

    private
  def gps_check_params
    params.require(:gps_check).permit(:image)
  end
end