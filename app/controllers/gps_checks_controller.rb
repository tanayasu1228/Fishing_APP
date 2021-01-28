class GpsChecksController < ApplicationController
  def new
    @gps_check = GpsCheck.new
  end

  def create
    @gps_check = GpsCheck.new(gps_check_params)
    latitude = @gps_check.image.latitude
    longitude = @gps_check.image.longitude
    if latitude.nil? || longitude.nil?
      redirect_to new_gps_check_path, alert: "チェック結果： GPSデータがありません。カメラの位置情報設定を変更してください"
    else
      redirect_to new_gps_check_path, notice: "チェック結果： 写真からGPSデータが確認されました。投稿ができる状態です" 
    end
  end

    private
  def gps_check_params
    params.require(:gps_check).permit(:image)
  end
end