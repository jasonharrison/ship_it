class DropOffPackage < ApplicationRecord
  belongs_to :user
  validates :tracking_ref, presence: true, tracking_number: { message: "is not valid" }
end
