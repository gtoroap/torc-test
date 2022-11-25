require_relative 'item_line'
class Invoice
  attr_accessor :taxes, :item_lines

  def initialize(item_lines = nil)
    raise ArgumentError unless item_lines

    @item_lines = item_lines
  end

  def valid?
    @item_lines.all? { |item_line| item_line.valid? }
  end

  def print_receipt
    return 'Invoice has invalid item lines. Please, fix errors and try again.' unless valid?

    result = ''
    @item_lines.each do |item_line|
      result += "#{item_line.quantity} #{item_line.description}: #{item_line.total}\n"
    end
    result += "Sales Taxes: #{@item_lines.sum(&:taxes_in_total).truncate(2)}\n"
    result += "Total: #{@item_lines.sum(&:total).truncate(2)}\n\n"
  end
end
