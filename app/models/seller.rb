class Seller < ApplicationRecord
  belongs_to :user
  has_many :seller_jobs, class_name: "Job", foreign_key: "seller_id", dependent: :destroy
  has_one :hardware_spec, dependent: :destroy

  validates :cpu, presence: true, numericality: { greater_than: 0 }
  validates :ram, presence: true, numericality: { greater_than: 0 }
  validates :storage, presence: true, numericality: { greater_than: 0 }
  validates :price_per_hour, presence: true, numericality: { greater_than: 0 }

  def average_rating
    seller_jobs.joins(:reviews).average('reviews.rating')&.round(1) || 0
  end

  def total_earnings
    user.transactions.where(transaction_type: :deposit, status: :success).sum(:amount)
  end

  def active_jobs_count
    seller_jobs.active.count
  end

  def available_resources
    {
      cpu: cpu - seller_jobs.active.sum(:cpu_usage),
      ram: ram - seller_jobs.active.sum(:ram_usage),
      storage: storage - seller_jobs.active.sum(:storage_usage)
    }
  end
end
