class CustomerProperty < ActiveRecord::Base
  belongs_to :customer
  belongs_to :property

  validates :customer, presence: true
  validates :property, presence: true
end
