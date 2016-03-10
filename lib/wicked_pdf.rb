# wkhtml2pdf Ruby interface
# http://code.google.com/p/wkhtmltopdf/

require 'logger'
require 'digest/md5'
require 'rbconfig'

if (RbConfig::CONFIG['target_os'] =~ /mswin|mingw/) && (RUBY_VERSION < '1.9')
  require 'win32/open3'
else
  require 'open3'
end

begin
  require 'active_support/core_ext/module/attribute_accessors'
rescue LoadError
  require 'active_support/core_ext/class/attribute_accessors'
end

begin
  require 'active_support/core_ext/object/blank'
rescue LoadError
  require 'active_support/core_ext/blank'
end

require 'wicked_pdf/version'
require 'wicked_pdf/railtie'
require 'wicked_pdf/tempfile'
require 'wicked_pdf/middleware'
require 'wicked_pdf/pdf/from_string'
require 'wicked_pdf/pdf/from_html_file'
require 'wicked_pdf/pdf/from_url'

class WickedPdf
  DEFAULT_BINARY_VERSION = Gem::Version.new('0.9.9')
  BINARY_VERSION_WITHOUT_DASHES = Gem::Version.new('0.12.0')
  EXE_NAME = 'wkhtmltopdf'
  @@config = {}
  cattr_accessor :config

  def initialize(wkhtmltopdf_binary_path = nil)
    # @exe_path = wkhtmltopdf_binary_path || find_wkhtmltopdf_binary_path


    # retrieve_binary_version
  end

  def pdf_from_html_file(filepath, options = {})
    PDF::FromHTMLFile.new(filepath, options)
  end

  def pdf_from_string(string, options = {})
    PDF::FromString.new(string, options)
  end

  def pdf_from_url(url, options = {})
    PDF::FromURL.new(url, options)
  end

  private

  def get_binary_version
    @binary_version
  end

  def print_command(cmd)
    p '*' * 15 + cmd + '*' * 15
  end

  def retrieve_binary_version
    _stdin, stdout, _stderr = Open3.popen3(@exe_path + ' -V')
    @binary_version = parse_version(stdout.gets(nil))
  rescue StandardError
  end

  def parse_version(version_info)
    match_data = /wkhtmltopdf\s*(\d*\.\d*\.\d*\w*)/.match(version_info)
    if match_data && (2 == match_data.length)
      Gem::Version.new(match_data[1])
    else
      DEFAULT_BINARY_VERSION
    end
  end
end
