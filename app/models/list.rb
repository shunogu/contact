class List < ApplicationRecord
  validates :company, :person, :memo, presence: true
end
