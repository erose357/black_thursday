require_relative 'transaction'
require 'csv'

class TransactionRepository
  attr_reader :data, :parent

  def initialize(file_path, parent)
    @data = parse_csv(file_path)
    @parent = parent
  end

  def inspect
    "#<#{self.class} #{data.size} rows>"
  end

  def parse_csv(file)
    data_hash = {}
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      data_hash[row[:id].to_i] = Transaction.new(Hash[row], self)
    end
    @data = data_hash
  end

  def all
    @data.values
  end

  def find_by_id(transaction_id)
    @data[transaction_id]
  end

  def find_all_by_invoice_id(invoice_id)
    @data.values.find_all { |t| t.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(cc_number)
    @data.values.find_all { |t| t.credit_card_number == cc_number }
  end

  def find_all_by_result(result)
    @data.values.find_all { |t| t.result == result }
  end
end
