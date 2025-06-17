class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :seller, dependent: :destroy
  has_many :buyer_jobs, class_name: "Job", foreign_key: "buyer_id", dependent: :destroy
  has_many :seller_jobs, class_name: "Job", foreign_key: "seller_id", dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :hardware_spec, dependent: :destroy

  # Combined jobs association
  has_many :jobs, -> { distinct }, through: :buyer_jobs, source: :job
  has_many :jobs, -> { distinct }, through: :seller_jobs, source: :job

  after_initialize :set_default_role, if: :new_record?

  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: %w[buyer seller admin] }

  def jobs
    Job.where("buyer_id = ? OR seller_id = ?", id, id)
  end

  def buyer?
    role == "buyer"
  end

  def seller?
    role == "seller"
  end

  def buyer!
    update(role: "buyer")
  end

  def seller!
    update(role: "seller")
  end

  def avatar_url
    avatar.attached? ? avatar.service_url : "https://avatar.iran.liara.run/public"
  end

  def total_spent
    transactions.where(type: 'purchase').sum(:amount)
  end

  def total_earned
    transactions.where(type: 'sale').sum(:amount)
  end

  def active_jobs
    buyer_jobs.active
  end

  def completed_jobs
    buyer_jobs.completed
  end

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def can_become_seller?
    buyer? && !seller.present?
  end

  def can_become_buyer?
    seller? && seller_jobs.active.empty?
  end

  private

  def set_default_role
    self.role ||= "buyer"
  end
  #protects the admin role from being set by users
  def set_admin_role
    if self.role != "admin"
      errors.add(:role, "cannot be set to admin by users")
      throw(:abort)
    else
      self.role = "admin"
    end
  end
  def admin?
    if role == "admin"
      true
    else
      false
    end
  end

end
