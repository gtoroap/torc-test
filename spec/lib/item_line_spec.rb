require 'item_line'

RSpec.describe ItemLine do
  let(:qty) { 1 }
  let(:desc) { 'TV' }
  let(:prc) { 1.0 }
  let(:imp) { false }
  let(:item_line) { ItemLine.new(qty, desc, prc, imp) }

  context '#initialize' do
    it 'should return a instance of ItemLine' do
      expect(item_line).to be_an_instance_of(ItemLine)
      expect(qty).to eq(1)
      expect(desc).to eq('TV')
      expect(prc).to eq(1.0)
      expect(imp).to be false
    end
  end

  context '#valid?' do
    let(:bad_qty) { '1' }
    let(:bad_desc) { nil }
    let(:bad_prc) { 1 }
    let(:bad_imp) { nil }
    let(:bad_item_line) { ItemLine.new(bad_qty, bad_desc, bad_prc, bad_imp) }

    context 'when arguments are invalid' do
      it 'should return false' do
        expect(bad_item_line.valid?).to be false
      end
    end

    context 'when item_lines are valid' do
      it 'should return true' do
        expect(item_line.valid?).to be true
      end
    end
  end

  context '#apply_tax?' do
    context 'when apply taxes' do
      it 'should return true' do
        expect(item_line.apply_tax?).to be true
      end
    end

    context 'when do not apply taxes' do
      let(:desc_not_apply) { 'apple' }
      let(:not_apply_item_line) { ItemLine.new(qty, desc_not_apply, prc, imp) }

      it 'should return false' do
        expect(not_apply_item_line.apply_tax?).to be false
      end
    end
  end

  context '#extract_from' do
    let(:item_line_str_1) { '1 book at 10.0' }
    let(:item_line_str_2) { '2 imported pack of pills at 5.0' }
    let(:item_line_str_3) { '3 imported box of chocolate at 7.0' }

    it 'should return an array of fields' do
      expect(ItemLine.extract_from(item_line_str_1)).to eq([1, 'book', 10.0, false])
      expect(ItemLine.extract_from(item_line_str_2)).to eq([2, 'imported pack of pills', 5.0, true])
      expect(ItemLine.extract_from(item_line_str_3)).to eq([3, 'imported box of chocolate', 7.0, true])
    end
  end

  context '#calculate_taxes' do
    context 'when exempted item exist' do
      let(:qty_1) { 1 }
      let(:desc_1) { 'book' }
      let(:prc_1) { 10.0 }
      let(:imp_1) { false }
      let(:item_line_1) { ItemLine.new(qty_1, desc_1, prc_1, imp_1) }

      it 'should return proper calculated taxes' do
        expect(item_line_1.taxes).to eq(0)
      end
    end

    context 'when imported item exist' do
      let(:qty_2) { 2 }
      let(:desc_2) { 'pack of pills' }
      let(:prc_2) { 5.0 }
      let(:imp_2) { true }
      let(:item_line_2) { ItemLine.new(qty_2, desc_2, prc_2, imp_2) }

      it 'should return proper calculated taxes' do
        expect(item_line_2.taxes).to eq(0.25)
      end
    end

    context 'when imported but exempted item exist' do
      let(:qty_3) { 3 }
      let(:desc_3) { 'box of chocolate' }
      let(:prc_3) { 7.0 }
      let(:imp_3) { true }
      let(:item_line_3) { ItemLine.new(qty_3, desc_3, prc_3, imp_3) }

      it 'should return proper calculated taxes' do
        expect(item_line_3.taxes).to eq(0.35)
      end
    end
  end
end
