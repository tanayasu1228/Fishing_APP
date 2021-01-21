if Rails.env.production? || Rails.env.development?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_SECRET_KEY'],
      region: ENV['S3_REGION']
    }
    config.fog_directory = ENV['S3_BUCKET']
    config.asset_host = "https://fishingapp-angler-s3-bucket.s3.amazonaws.com"

    # キャッシュにS3を指定
    # config.cache_storage = :fog
    
    # 一般公開させて無いS3の場合は以下の設定を行う。（入れないとパスがうまく発行されない）
    # config.fog_public = false
  end
end