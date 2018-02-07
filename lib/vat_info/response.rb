module VatInfo
  class Response
    attr_accessor :status_code, :body

    def initialize(status_code, body)
      @status_code = status_code
      @body        = body
    end

    def ok?
      status_code == 200 || status_code == 201
    end
  end
end
