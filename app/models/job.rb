class Job < ApplicationRecord
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  # Define status constants
  PENDING = 0
  IN_PROGRESS = 1
  COMPLETED = 2
  CANCELLED = 3

  # Define scopes
  scope :active, -> { where(status: [PENDING, IN_PROGRESS]) }
  scope :completed, -> { where(status: COMPLETED) }
  scope :cancelled, -> { where(status: CANCELLED) }
  scope :pending, -> { where(status: PENDING) }
  scope :in_progress, -> { where(status: IN_PROGRESS) }

  # Define status methods
  def pending?
    status == PENDING
  end

  def in_progress?
    status == IN_PROGRESS
  end

  def completed?
    status == COMPLETED
  end

  def cancelled?
    status == CANCELLED
  end

  # Define status setters
  def pending!
    update(status: PENDING)
  end

  def in_progress!
    update(status: IN_PROGRESS)
  end

  def completed!
    update(status: COMPLETED)
  end

  def cancelled!
    update(status: CANCELLED)
  end
end
