class Post < ApplicationRecord
  mount_uploader :fish_image, ImageUploader

  belongs_to :user
  belongs_to :tournament, optional: true
end
