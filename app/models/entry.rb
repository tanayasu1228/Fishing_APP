class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  # has_many :posts, dependent: :destroy  
end
