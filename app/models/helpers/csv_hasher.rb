require 'csv'

class Helpers::CsvHasher
  attr_reader :csv_data_array

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(csv_file_path)
    @csv_data_array = CSV.read(csv_file_path)
  end

  def call
    attribute_types = csv_data_array.first
    attributes = csv_data_array[1..-1]

    attributes
      .select{ |row| row.present? }
      .map do |single_property_attributes|
        attribute_types
          .zip(single_property_attributes)
          .to_h
      end
  end
end

