require_relative 'invoice'

class InvoiceImporter
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    raise ArgumentError unless file_path

    invoices = []
    item_lines = []
    lines = File.readlines(File.join(__dir__, file_path))
    lines.each do |line|
      if line.strip.empty?
        invoices << Invoice.new(item_lines)
        item_lines = []
      else
        quantity, description, price, imported = ItemLine.extract_from(line)
        item_line = ItemLine.new(quantity, description, price, imported)
        item_lines << item_line if item_line.valid?
      end
    end

    invoices << Invoice.new(item_lines) unless item_lines.empty?
    invoices
  end
end
