class Tournament < ApplicationRecord
  validates :date, presence: true
  validates :fishing_ground, presence: true
  validates :fishing_style, presence: true
  validates :condition, presence: true
  validates :fish_name, presence: true
  validates :keeper_size, presence: true
  validates :some_fish, presence: true

  validates_acceptance_of :confirming
  after_validation :check_confirming

  belongs_to :user
  has_many :entries

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  # トーナメントにエントリーしているか判断するメソッド
  def entry_completed_by?(user)
    entries.where(user_id: user.id).exists?
  end

end
