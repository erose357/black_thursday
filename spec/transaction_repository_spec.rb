require_relative '../lib/transaction_repository'

RSpec.describe TransactionRepository do
  let (:tr) { TransactionRepository.new('spec/fixtures/transactions_fixture.csv', 'parent') }

  it 'is a valid instance' do
    expect(tr).to be_an_instance_of(TransactionRepository)
  end

  describe 'Instance Methods' do
    describe '#all' do
      it 'returns Array of all Transaction instances' do
        expect(tr.all).to be_an_instance_of(Array)
        expect(tr.all.count).to eq(23)
        expect(tr.all[0]).to be_an_instance_of(Transaction)
      end
    end

    describe '#find_by_id' do
      it 'returns instance of Transaction with matching id' do
        transaction = tr.find_by_id(381)
        expect(transaction).to be_an_instance_of(Transaction)
        expect(transaction.result).to eq('success')
        expect(transaction.invoice_id).to eq(1195)
      end

      it 'returns nil if no match found' do
        expect(tr.find_by_id(100)).to be_nil
      end
    end
  end
end
