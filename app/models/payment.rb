class Payment < ApplicationRecord
  belongs_to :user, optional: true
  validates :amount, presence: true
  validates :description, presence: true
end
