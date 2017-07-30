class DropOffPackage < ApplicationRecord
  belongs_to :user
  validates :tracking_ref, presence: true,
    tracking_number: { message: "is not valid" },
    uniqueness: { message: "has already been dropped off"}
end
