class User < ApplicationRecord
  has_many :payments

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Method to return full_name
  def full_name
    "#{first_name} #{last_name}"
  end
end
