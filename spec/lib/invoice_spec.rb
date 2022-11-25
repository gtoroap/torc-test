require 'invoice'

RSpec.describe Invoice do
  let(:item_line_1) { ItemLine.new(1, 'book', 10.0, false) }
  let(:item_line_2) { ItemLine.new(1, 'apple', 2.0, false) }
  let(:item_lines) { [item_line_1, item_line_2] }
  let(:invoice) { Invoice.new(item_lines)}
  let(:printed_receipt) { "1 book: 10.0\n1 apple: 2.0\nSales Taxes: 0.0\nTotal: 12.0\n\n" }
  
  context '#initialize' do
    context 'when no item_lines' do
      it 'should raise an argument error formatted receipt' do
        expect { Invoice.new }.to raise_error(ArgumentError)
      end
    end

    context 'when item_lines exist' do
      it 'should return a instance of Invoice' do
        expect(Invoice.new(item_lines)).to be_an_instance_of(Invoice)
      end
    end
  end

  context '#valid?' do
    let(:wrong_item_lines) { [ItemLine.new('bad', 'bad', 'bad', 'bad'), ItemLine.new('wrong', 'wrong', 'wrong', 'wrong')] }
    let(:invalid_invoice) { Invoice.new(wrong_item_lines)}

    context 'when item_lines are invalid' do
      it 'should return false' do
        expect(invalid_invoice.valid?).to be false
      end
    end

    context 'when item_lines are valid' do
      it 'should return true' do
        expect(invoice.valid?).to be true
      end
    end
  end

  context '#print_receipt' do
    it 'should display formatted receipt' do
      expect(invoice.print_receipt).to eq(printed_receipt)
    end
  end
end
