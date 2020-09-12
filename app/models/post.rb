class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tournament, optional: true
end
