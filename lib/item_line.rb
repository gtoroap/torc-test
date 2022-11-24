class ItemLine
  FOOD_LIST = %w(apple banana chocolate kiwi pear pineapple)
  MEDICAL_PRODUCT_LIST = %w(glove mask pill syringe)
  BOOK_LIST =  %w(book magazine)

  attr_accessor :quantity, :description, :price, :imported

  def initialize(quantity, description, price, imported)
    @quantity = quantity
    @description = description
    @price = price
    @imported = imported
  end

  def apply_tax?
    exempted_items = FOOD_LIST.concat(MEDICAL_PRODUCT_LIST).concat(BOOK_LIST)
    patterns = exempted_items.map { |item| Regexp.new(item) }
    patterns.select {|elem| elem =~ description}.empty?
  end
end
