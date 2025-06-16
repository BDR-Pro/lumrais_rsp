class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :seller, dependent: :destroy 

  after_initialize :set_default_role, if: :new_record?

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
