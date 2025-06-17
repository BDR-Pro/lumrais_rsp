class Seller < ApplicationRecord
  belongs_to :user
  has_many :jobs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :hardware_spec, dependent: :destroy

  validates :cpu, presence: true, numericality: { greater_than: 0 }
  validates :ram, presence: true, numericality: { greater_than: 0 }
  validates :storage, presence: true, numericality: { greater_than: 0 }
  validates :price_per_hour, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[active inactive suspended] }

  before_validation :set_default_status, on: :create

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def total_earnings
    transactions.completed.sum(:amount)
  end

  def active_jobs_count
    jobs.active.count
  end

  def available_resources
    {
      cpu: cpu - jobs.active.sum(:cpu_usage),
      ram: ram - jobs.active.sum(:ram_usage),
      storage: storage - jobs.active.sum(:storage_usage)
    }
  end

  private

  def set_default_status
    self.status ||= 'active'
  end
end
