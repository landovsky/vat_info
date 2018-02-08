require 'vat_info/version'
require 'vat_info/utils'
require 'vat_info/request'
require 'vat_info/response'
require 'vat_info/query'
require 'vat_info/models'

module VatInfo
  def self.unreliable_payer(*vat_ids)
    request  = VatInfo::Request::UnreliablePayer.new(*vat_ids).to_xml
    response = VatInfo::Query.call(request, :get_status_nespolehlivy_platce)

    if response.ok?
      status_raw    = response.raw[:status_nespolehlivy_platce_response][:status]
      status        = VatInfo::Models::Status.new(status_raw).data

      payers_raw    = VatInfo::Utils.wrap_in_array(response.raw[:status_nespolehlivy_platce_response][:status_platce_dph])
      payers        = VatInfo::Models::VatPayers.new(payers_raw).data

      response.body = status.merge(payers)
    end
    response
  end

  def self.unreliable_payer_extended
    # endpoint = :get_status_nespolehlivy_platce_rozsireny
  end

  def self.unreliable_payer_list
    # endpoint = :get_seznam_nespolehlivy_platce
  end
end
