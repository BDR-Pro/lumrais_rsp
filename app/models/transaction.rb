class Transaction < ApplicationRecord
  belongs_to :user

  enum transaction_type: { deposit: 0, withdrawal: 1 }
  enum status: { pending: 0, success: 1, failed: 2 }
end
