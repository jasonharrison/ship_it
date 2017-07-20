class DropOffPackage < ApplicationRecord
  belongs_to :user
  validates :tracking_ref, presence: true
end
