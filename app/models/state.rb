class State < ActiveRecord::Base

  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def self.paginate(page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = State.count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    states = State.limit(max_records_per_page).offset(current_offset)
    current_record_count = states.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: states

    }
  end

  def self.search(search_criteria, page=1)
    page ||= 1

    # Set the pagination info on every data pull
    total_record_count = State.where(" code LIKE LOWER('%#{search_criteria}%') OR name LIKE LOWER('%#{search_criteria}%') ").count
    pages  = (total_record_count.to_f / ENV['MAX_RECORDS_PER_PAGE'].to_f).ceil
    current_page = page

    max_records_per_page = ENV['MAX_RECORDS_PER_PAGE'].to_i
    current_offset = ((page.to_i*max_records_per_page))-max_records_per_page
    states = State.where(" code LIKE LOWER('%#{search_criteria}%') OR name LIKE LOWER('%#{search_criteria}%') ").limit(max_records_per_page).offset(current_offset)
    current_record_count = states.try(:count)

    {
      current_page: page,
      pages: pages,
      max_records_per_page: max_records_per_page,
      current_offset: current_offset,
      current_record_count: current_record_count,
      total_record_count: total_record_count,
      records: states
    }
  end   

end
