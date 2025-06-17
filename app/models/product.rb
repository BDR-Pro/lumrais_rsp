class Product < ApplicationRecord
  belongs_to :seller, class_name: "User"
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :cpu_cores, presence: true, numericality: { greater_than: 0 }
  validates :ram_gb, presence: true, numericality: { greater_than: 0 }
  validates :storage_gb, presence: true, numericality: { greater_than: 0 }

  scope :featured, -> { where(featured: true) }
  scope :active, -> { where(active: true) }
  scope :by_seller, ->(seller_id) { where(seller_id: seller_id) }

  def formatted_price
    "$#{price.to_f.round(2)}"
  end

  def specs_summary
    "#{cpu_cores} CPU cores, #{ram_gb}GB RAM, #{storage_gb}GB Storage"
  end
end 