class Review < ApplicationRecord
  belongs_to :job
  belongs_to :reviewer, class_name: "User"
  belongs_to :reviewee, class_name: "User"
end
