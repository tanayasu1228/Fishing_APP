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

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

end
