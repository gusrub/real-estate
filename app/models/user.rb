class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, presence: true

  has_secure_password

  enum role: [:admin, :agent, :customer]
  enum status: [:needs_activation, :active]

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.is_valid_login?(username, password)
    User.find_by(email: username).try(:authenticate, password)
  end
end