require 'test_helper'

describe Itiel::Load::BatchCSV do
  before :each do
    @filename = File.expand_path("#{File.dirname(__FILE__)}/../../../tmp/output")
    File.unlink(@filename) if File.exist?(@filename)

    @input = [
        {
            "id"   => 1,
            "name" => "Subject Name"
        },
        {
            "id"   => 2,
            "name" => "Subject Name"
        },
        {
            "id"   => 3,
            "name" => "Subject Name"
        }
    ]
  end

  describe "Slice by 1" do
    before :each do
      @csv_output = Itiel::Load::BatchCSV.new(@filename, 1)
      @csv_output.persist(@input)
    end

    it "It generates 3 csv files" do
      assert_equal CSV.read("#{@filename}-1.csv").to_a, [['id', 'name'], ['1', 'Subject Name']]
      assert_equal CSV.read("#{@filename}-2.csv").to_a, [['id', 'name'], ['2', 'Subject Name']]
      assert_equal CSV.read("#{@filename}-3.csv").to_a, [['id', 'name'], ['3', 'Subject Name']]
    end
  end

  describe "Slice by 2" do
    before :each do
      @csv_output = Itiel::Load::BatchCSV.new(@filename, 2)
      @csv_output.persist(@input)
    end

    it "It generates 2 csv files" do
      assert_equal CSV.read("#{@filename}-1.csv").to_a, [['id', 'name'], ['1', 'Subject Name'], ['2', 'Subject Name']]
      assert_equal CSV.read("#{@filename}-2.csv").to_a, [['id', 'name'], ['3', 'Subject Name']]
    end
  end

end
