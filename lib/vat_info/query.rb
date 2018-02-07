require 'savon'

require 'vat_info/models/vat_payer'
require 'vat_info/models/vat_payers'

module VatInfo
  class Query
    WSDL = 'http://adisrws.mfcr.cz/adistc/axis2/services/rozhraniCRPDPH.rozhraniCRPDPHSOAP?wsdl'.freeze
    TIMEOUT = 2

    def self.call(request, endpoint, wsdl = WSDL, timeout = TIMEOUT)
      client = Savon.client(wsdl: wsdl, open_timeout: timeout)

      begin
        response = client.call(endpoint, xml: request)
        if response.success?
          Response.new(status_code: 200, body: response.body)
        else
          Response.new(status_code: 503)
        end
      rescue Net::OpenTimeout
        Response.new(status_code: 408)
      end
    end
  end

  class Response
    attr_accessor :status_code, :body

    def initialize(status_code:, body:)
      @status_code = status_code
      @body        = body
    end

    def ok?
      status_code == 200
    end
  end
end
