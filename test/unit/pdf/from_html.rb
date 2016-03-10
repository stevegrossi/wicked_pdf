require 'test_helper'

WickedPdf.config = { :exe_path => ENV['WKHTMLTOPDF_BIN'] || '/usr/local/bin/wkhtmltopdf' }
HTML_DOCUMENT = '<html><body>Hello World</body></html>'

# Provide a public accessor to the normally-private parse_options function.
# Also, smash the returned array of options into a single string for
# convenience in testing below.
class WickedPdf
  def get_parsed_options(opts)
    parse_options(opts).join(' ')
  end

  def get_valid_option(name)
    valid_option(name)
  end

  def set_binary_version_to(version)
    @binary_version = version
  end
end

class PDFFromHTMLTest < ActiveSupport::TestCase
  def setup
    @wp = WickedPdf.new
  end

  test 'should generate PDF from html document' do
    raise PDF::FromHTMLFile.new(HTML_DOCUMENT, {}).inspect
    # pdf = wp.pdf_from_string HTML_DOCUMENT
    # assert pdf.start_with?('%PDF-1.4')
    # assert pdf.rstrip.end_with?('%%EOF')
    # assert pdf.length > 100
  end
end
