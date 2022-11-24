class ItemLine
  attr_accessor :quantity, :description, :price, :imported

  def initialize(quantity, description, price, imported)
    @quantity = quantity
    @description = description
    @price = price
    @imported = imported
  end
end