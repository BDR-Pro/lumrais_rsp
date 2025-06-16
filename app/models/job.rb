class Job < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  enum status: { pending: 0, in_progress: 1, completed: 2, cancelled: 3 }
end
