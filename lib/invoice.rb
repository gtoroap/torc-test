require_relative 'item_line'

class Invoice
  TAX_RATE = 0.1
  IMPORTED_RATE = 0.05
  ROUNDED_TO = 0.05

  attr_accessor :taxes
  def initialize(item_lines)
    @item_lines = item_lines
    @taxes = 0.0
  end

  def apply_taxes
    @item_lines.each do |item_line|
      @taxes += calculate_taxes(item_line)
    end

    @taxes = @taxes.truncate(2)
  end

  private

  def calculate_taxes(item)
    taxes = 0.0
    taxes = item.quantity * round_by(item.price * TAX_RATE, ROUNDED_TO) if item.apply_tax?
    taxes += item.quantity * round_by(item.price * IMPORTED_RATE, ROUNDED_TO) if item.imported

    taxes
  end

  def round_by(value, increment)
    (value / increment).round * increment
  end
end

