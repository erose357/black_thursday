require_relative '../lib/transaction'

RSpec.describe Transaction do
  let (:t) { Transaction.new({ :id => '6',
                               :invoice_id => '8',
                               :credit_card_number => '4242424242424242',
                               :credit_card_expiration_date => '0220',
                               :result => 'success',
                               :created_at => '2012-02-26 20:57:09 UTC',
                               :updated_at => '2012-02-26 20:58:35 UTC' }, 'parent') }

  it 'is a valid instance' do
    expect(t).to be_an_instance_of(Transaction)
  end

  describe 'Attributes' do
    describe '@id' do
      it 'returns the id as integer' do
        expect(t.id).to be_an_instance_of(Integer)
        expect(t.id).to eq(6)
      end
    end

    describe '@invoice_id' do
      it 'returns the invoice_id as integer' do
        expect(t.invoice_id).to be_an_instance_of(Integer)
        expect(t.invoice_id).to eq(8)
      end
    end

    describe '@credit_card_number' do
      it 'returns the credit card number as Integer' do
        expect(t.credit_card_number).to be_an_instance_of(Integer)
        expect(t.credit_card_number).to eq(4242424242424242)
      end
    end

    describe '@credit_card_expiration_date' do
      it 'returns the credit card number expiration datea as String' do
        expect(t.credit_card_expiration_date).to be_an_instance_of(String)
        expect(t.credit_card_expiration_date).to eq('0220')
      end
    end

    describe '@result' do
      it 'returns the result as String' do
        expect(t.result).to be_an_instance_of(String)
        expect(t.result).to eq('success')
      end
    end

    describe '@created_at' do
      it 'returns the created at date as Time' do
        expect(t.created_at).to be_an_instance_of(Time)
        expect(t.created_at.to_s).to eq('2012-02-26 20:57:09 UTC')
      end
    end

    describe '@updated_at' do
      it 'returns the updated at date as Time' do
        expect(t.updated_at).to be_an_instance_of(Time)
        expect(t.updated_at.to_s).to eq('2012-02-26 20:58:35 UTC')
      end
    end
  end
end
