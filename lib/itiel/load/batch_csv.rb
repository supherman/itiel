require 'csv'

module Itiel
  module Load
    #
    # Loads the data stream into multiple CSV files
    #
    # Usage:
    #
    #     @csv_batch = Itiel::Load::CSVFile.new('filename', 10)
    #
    class BatchCSV
      include ChainedStep
      include Itiel::Nameable

      def initialize(file_name, slices)
        @slices    = slices
        @file_name = file_name
      end

      def persist(input_stream)
        headers     = input_stream.collect(&:keys).flatten.uniq
        slice_count = 0
        input_stream.each_slice(@slices) do |slice|
          slice_count += 1
          CSV.open("#{@file_name}-#{slice_count}.csv", 'w') do |csv|
            csv << headers
            slice.each do |row|
              csv_row = []
              headers.each do |h|
                csv_row << row[h]
              end
              csv << csv_row
            end
          end
        end
      end
    end
  end
end
