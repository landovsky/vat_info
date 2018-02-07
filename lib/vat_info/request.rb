require 'nokogiri'
require 'vat_info/request/unreliable_payer'

module VatInfo
  class Request
    SOAP_ENV_SCHEMA = 'http://schemas.xmlsoap.org/soap/envelope/'.freeze

    def envelope
      Nokogiri::XML::Builder.new('encoding' => 'UTF-8') do |xml|
        xml['soapenv'].Envelope('xmlns:soapenv' => 'http://schemas.xmlsoap.org/soap/envelope/') do
          xml['soapenv'].Body do
          end
        end
      end.doc
    end
  end
end
