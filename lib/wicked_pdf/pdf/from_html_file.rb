class PDF
  class FromHTMLFile

    def initialize(filepath, options)
      FromURL.new("file:///#{filepath}", options)
    end
  end

end
