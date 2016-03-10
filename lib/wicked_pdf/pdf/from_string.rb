class PDF
  class FromString

    def initialize(string, options)
      options = options.dup
      options.merge!(WickedPdf.config) { |_key, option, _config| option }
      string_file = WickedPdfTempfile.new('wicked_pdf.html', options[:temp_path])
      string_file.binmode
      string_file.write(string)
      string_file.close

      pdf = FromHTMLFile.new(string_file.path, options)
      pdf
    rescue => e
      raise "Error: #{e}"
    ensure
      string_file.close! if string_file
    end
  end

end
