class Pet < ApplicationRecord
  validates :name, presence: true

  def calculate_age
    return 3 - 1
  end
end
