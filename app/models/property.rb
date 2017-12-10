class Property < ActiveRecord::Base
  belongs_to :zipcode
  belongs_to :property_classification
  belongs_to :status

  has_many :property_cashflow_reports

  # validates :street_address, uniqueness: { case_sensitve: false }

  def self.import_properties(file)
    ActiveRecord::Base.transaction do
      Helpers::CsvHasher.call(file.path)
        .each do |property_attributes|
          binding.pry
          zipcode        = property_attributes.fetch("ZIP")
          classification = property_attributes.fetch("HOME TYPE")
          status         = property_attributes.fetch("STATUS")

          # property_attributes.

        # TODO: sanitize parameters to create db row below
          Property.find_or_create_by(property_attributes)
        end
      end
  end
end
