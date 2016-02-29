class Property < ActiveRecord::Base
  belongs_to :state
  belongs_to :agent
  before_destroy :delete_photo
  before_save :save_photo
  has_many :customer_properties
  has_many :customers, through: :customer_properties

  enum status: [:for_sale, :sold]

  validates :title, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 } 
  validates :street_name, presence: true
  validates :street_number, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :state, presence: true
  validates :status, presence: true
  validates :agent, presence: true

  def address
    [street_number, street_name, suite].join(' ')
  end

  def full_address
    "#{street_number} #{street_name} #{city} #{state.code} #{zipcode}"
  end

  def location
    "#{city}, #{state.code}, #{zipcode}"
  end  

  def self.paginate(page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = Property.count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    properties = Property.limit(max_records_per_page).offset(current_offset)
    current_record_count = properties.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: properties

    }
  end

  def self.search(search_criteria, page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = Property.where(" title LIKE LOWER('%#{search_criteria}%') OR description LIKE LOWER('%#{search_criteria}%') ").count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    properties = Property.where(" title LIKE LOWER('%#{search_criteria}%') OR description LIKE LOWER('%#{search_criteria}%') ").limit(max_records_per_page).offset(current_offset)
    current_record_count = properties.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: properties
    }
  end

  private
    def delete_photo
      if photo
        File::delete(Rails.root.join('public', 'uploads', photo))
      end
    end  

    def save_photo
      if photo_changed?
        FileUtils::mv(Rails.root.join('tmp', photo), Rails.root.join('public', 'uploads', photo))
      end
    end
end
