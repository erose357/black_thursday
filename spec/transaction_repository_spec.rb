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

    describe '#find_all_by_invoice_id' do
      it 'returns one or more matches to invoice_id provided' do
        transaction = tr.find_all_by_invoice_id(3949)

        expect(transaction.count).to eq(2)
        expect(transaction).to be_an_instance_of(Array)
        expect(transaction[0]).to be_an_instance_of(Transaction)
        expect(transaction.map(&:id)).to eq([2506, 2695])
      end

      it 'returns [] if no match found' do
        transaction = tr.find_all_by_invoice_id(100)

        expect(transaction).to eq([])
      end
    end

    describe '#find_all_by_credit_card_number' do
      it 'returns one or more matches to credit card number provided' do
        transaction = tr.find_all_by_credit_card_number(4230049223634282)

        expect(transaction.count).to eq(1)
        expect(transaction[0]).to be_an_instance_of(Transaction)
        expect(transaction).to be_an_instance_of(Array)
        expect(transaction[0].id).to eq(2287)
      end

      it 'returns [] if no matches found' do
        transaction = tr.find_all_by_invoice_id(100)

        expect(transaction).to eq([])
      end
    end

    describe '#find_all_by_result' do
      it "returns one or more matches to 'success' result provided" do
        transaction = tr.find_all_by_result('success')

        expect(transaction.count).to eq(17)
        expect(transaction).to be_an_instance_of(Array)
        expect(transaction[0]).to be_an_instance_of(Transaction)
        expect(transaction.map(&:id)).to include(2437, 381, 2287)
      end

      it "returns one or more matches to 'failed' result provided" do
        transaction = tr.find_all_by_result('failed')

        expect(transaction.count).to eq(6)
        expect(transaction).to be_an_instance_of(Array)
        expect(transaction[0]).to be_an_instance_of(Transaction)
        expect(transaction.map(&:id)).to include(2961, 1709, 608)
      end

      it 'returns [] if no matches found' do
        transaction = tr.find_all_by_result(nil)

        expect(transaction).to eq([])
      end
    end
  end
end
