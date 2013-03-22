require 'test_helper'

describe Itiel::Transform::ConstantColumn do
  before :each do
    @input = [
        { 'id' => '1', 'name' => 'foo' },
        { 'id' => '2', 'name' => 'bar' }
    ]

    @expected_output = [
        { "id"     => "1" },
        { "id"     => "2" }
    ]

    @transformation = Itiel::Transform::RemoveColumns.new('name')
  end

  it "appends a field with a constant value to the stream" do
    assert_equal @expected_output, @transformation.transform!(@input)
  end
end
