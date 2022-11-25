require_relative 'invoice_importer'

invoices = InvoiceImporter.new('invoices.txt').call
puts invoices.map(&:print_receipt)