require 'vat_info/version'
require 'vat_info/utils'
require 'vat_info/request'
require 'vat_info/response'
require 'vat_info/query'

require 'json'

module VatInfo
  def self.unreliable_payer(*vat_ids)
    request  = VatInfo::Request::UnreliablePayer.new(*vat_ids).to_xml
    response = VatInfo::Query.call(request, :get_status_nespolehlivy_platce)

    payers   = VatInfo::Utils.wrap_in_array(response.body[:status_nespolehlivy_platce_response][:status_platce_dph])
    response.body = VatInfo::Models::VatPayers.new(payers).data if response.ok?
    response
  end

  def self.unreliable_payer_extended
    # endpoint = :get_status_nespolehlivy_platce_rozsireny
  end

  def self.unreliable_payer_list
    # endpoint = :get_seznam_nespolehlivy_platce
  end
end
