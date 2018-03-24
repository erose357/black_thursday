require_relative '../lib/item'

RSpec.describe Item do
  let (:i) { Item.new({:id => '123456'.to_i,
                       :name => 'Pencil',
                       :description => 'You can use it to write things',
                       :unit_price => BigDecimal.new(10.99, 4),
                       :created_at => '2007-06-04 21:35:10 UTC',
                       :updated_at => '2016-01-11 09:34:06 UTC'}) }

  it 'is a valid instance' do
    expect(i).to be_an_instance_of(Item)
  end

  describe 'Attributes' do
    describe 'id' do
      it 'returns the id of the item as an Integer' do
        expect(i.id).to be_an_instance_of(Integer)
        expect(i.id).to eq(123456)
      end
    end

    describe 'name' do
      it 'returns the name of the item as a String' do
        expect(i.name).to be_an_instance_of(String)
        expect(i.name).to eq('Pencil')
      end
    end

    describe 'description' do
      it 'returns the description of the item as a String' do
        expect(i.description).to be_an_instance_of(String)
        expect(i.description).to eq('You can use it to write things')
      end
    end

    describe 'unit_price' do
      it 'returns the unit price as a BigDecimal' do
        expect(i.unit_price).to be_an_instance_of(BigDecimal)
        expect(i.unit_price.to_f).to eq(10.99)
      end
    end

    describe 'created_at' do
      it 'returns date the item was first created as Time' do
        expect(i.created_at).to be_an_instance_of(Time)
        expect(i.created_at.to_s).to eq('2007-06-04 21:35:10 UTC')
      end
    end
  end

  describe 'Instance methods' do
    describe '#format_time' do
      it 'returns input time String as a UTC Time instance' do
        time = i.format_time("1993-09-29 11:56:40 UTC")
        expect(time).to be_an_instance_of(Time)
        expect(time.year).to eq(1993)
        expect(time.month).to eq(9)
        expect(time.day).to eq(29)
        expect(time.hour).to eq(11)
        expect(time.min).to eq(56)
        expect(time.sec).to eq(40)
        expect(time.utc?).to eq(true) 
      end
    end
  end
end
