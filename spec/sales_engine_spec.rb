require 'sales_engine'

RSpec.describe SalesEngine do
  let (:se) { SalesEngine.new }

  it 'is a valid instance' do
    expect(se).to be_an_instance_of(SalesEngine)
  end

  describe 'Class methods' do
    describe '.from_csv' do
    end
  end

  describe 'Attributes' do
    it 'can access merchants attribute'
  end
end
