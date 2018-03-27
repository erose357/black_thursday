require_relative '../lib/invoice'

RSpec.describe Invoice do
  let (:i) { Invoice.new({:id => 6,
                          :customer_id => 7,
                          :merchant_id => 8,
                          :status => 'pending',
                          :created_at => '2007-06-04',
                          :updated_at => '2016-01-11'}, 'parent' ) }

  it 'is a valid instance' do
    expect(i).to be_an_instance_of(Invoice)
  end

  describe 'Attributes' do
    describe '@id' do
      it 'returns the instance id' do
        expect(i.id).to eq(6)
        expect(i.id).to be_an_instance_of(Integer)
      end
    end
    
    describe '@customer_id' do
      it 'returns the customer_id' do
        expect(i.customer_id).to eq(7)
        expect(i.customer_id).to be_an_instance_of(Integer)
      end
    end

    describe '@merchant_id' do
      it 'returns the merchant_id' do
        expect(i.merchant_id).to eq(8)
        expect(i.merchant_id).to be_an_instance_of(Integer)
      end
    end

    describe '@status' do
      it 'returns the status' do
        expect(i.status).to eq(:pending)
        expect(i.status).to be_an_instance_of(Symbol)
      end
    end

    describe '@created_at' do
      it 'returns the time created_at' do
        expect(i.created_at.to_s).to eq('2007-06-04 00:00:00 -0600')
        expect(i.created_at).to be_an_instance_of(Time)
      end
    end

    describe '@updated_at' do
      it 'returns the time updated_at' do
        expect(i.updated_at.to_s).to eq('2016-01-11 00:00:00 -0700')
        expect(i.updated_at).to be_an_instance_of(Time)
      end
    end
  end
end
