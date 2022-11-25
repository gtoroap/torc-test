class ItemLine
  FOOD_LIST = %w(apple banana chocolate kiwi pear pineapple)
  MEDICAL_PRODUCT_LIST = %w(glove mask pill syringe)
  BOOK_LIST =  %w(book magazine)
  TAX_RATE = 0.1
  IMPORTED_RATE = 0.05
  ROUNDED_TO = 0.05

  attr_accessor :quantity, :description, :price, :imported, :taxes

  def initialize(quantity, description, price, imported)
    @quantity = quantity
    @description = description
    @price = price
    @imported = imported
    @taxes = 0.0
    calculate_taxes
  end

  def apply_tax?
    exempted_items = FOOD_LIST.concat(MEDICAL_PRODUCT_LIST).concat(BOOK_LIST)
    patterns = exempted_items.map { |item| Regexp.new(item) }
    patterns.select {|elem| elem =~ description}.empty?
  end

  def total
    (@quantity * (@price + @taxes)).round(2)
  end

  def taxes_in_total
    (@quantity * @taxes).round(2)
  end

  def valid?
    return false unless (quantity.is_a?(Integer) && quantity > 0) && (price.is_a?(Float) && price > 0.0)

    true
  end

  def self.extract_from(item_line)
    fields = item_line.strip.split(' ')
    quantity = fields.first.to_i
    price = fields.last.to_f
    description = fields[1..fields.size - 3].join(' ')
    imported = description.split(' ').first == 'imported' ? true : false
    [quantity, description, price, imported]
  end

  private

  def calculate_taxes
    return unless valid?

    @taxes = round_by(price * TAX_RATE, ROUNDED_TO) if apply_tax?
    @taxes += round_by(price * IMPORTED_RATE, ROUNDED_TO) if imported
    @taxes.round(2)
  end

  def round_by(value, increment)
    (value / increment).ceil * increment
  end
end
