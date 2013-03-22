module Itiel
  module Transform
    class RemoveColumns
      include ChainedStep
      include Itiel::Nameable

      def initialize(*args)
        @columns = args
      end

      def transform!(input_stream)
        input_stream.collect do |row|
          @columns.each { |col| row.delete col }
          row
        end
      end
    end
  end
end
