require_relative '../lib/customer'

RSpec.describe Customer do
  let (:c) { Customer.new({ :id => '6',
                            :first_name => 'Joan',
                            :last_name => 'Clarke',
                            :created_at => '2005-01-03',
                            :updated_at => '2005-04-20'}, 'parent') }

  it 'is a valid instance' do
    expect(c).to be_an_instance_of(Customer)
  end

  describe 'Attributes' do
    describe '@id' do
      it 'returns the id as Integer' do
        expect(c.id).to eq(6)
        expect(c.id).to be_an_instance_of(Integer)
      end
    end

    describe '@first_name' do
      it 'returns the first name' do
        expect(c.first_name).to be_an_instance_of(String)
        expect(c.first_name).to eq('Joan')
      end
    end

    describe '@last_name' do
      it 'returns the last name' do
        expect(c.last_name).to be_an_instance_of(String)
        expect(c.last_name).to eq('Clarke')
      end
    end

    describe '@created_at' do
      it 'returns created at as Time' do
        expect(c.created_at).to be_an_instance_of(Time)
        expect(c.created_at.to_s).to eq('2005-01-03 00:00:00 UTC')
      end
    end

    describe '@updated_at' do
      it 'returns updated at as Time' do
        expect(c.updated_at).to be_an_instance_of(Time)
        expect(c.updated_at.to_s).to eq('2005-04-20 00:00:00 UTC')
      end
    end
  end
end
