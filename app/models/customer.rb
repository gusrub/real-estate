class Customer < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :customer_properties
  has_many :properties, through: :customer_properties
  accepts_nested_attributes_for :user, allow_destroy: true

  validates :mobile, presence: true
  validates :user, presence: true

  enum title: [:mr, :mrs, :ms]

  validates :title, presence: true

  def full_name
    "#{title}.humanize #{first_name} #{last_name}"
  end

  def self.paginate(page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = Customer.count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    customers = Customer.limit(max_records_per_page).offset(current_offset)
    current_record_count = customers.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: customers

    }
  end

  def self.search(search_criteria, page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = Customer.joins(:user).where(" users.first_name LIKE LOWER('%#{search_criteria}%') OR users.last_name LIKE LOWER('%#{search_criteria}%') OR users.email LIKE LOWER('%#{search_criteria}%') ").count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    customers = Customer.joins(:user).where(" users.first_name LIKE LOWER('%#{search_criteria}%') OR users.last_name LIKE LOWER('%#{search_criteria}%') OR users.email LIKE LOWER('%#{search_criteria}%') ").limit(max_records_per_page).offset(current_offset)
    current_record_count = customers.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: customers
    }
  end 

  def self.to_csv
    attributes = %w{id title phone mobile user_id created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |customer|
        csv << attributes.map{ |attr| customer.send(attr) }
      end
    end
  end

end
