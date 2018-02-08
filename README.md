# VAT payer info CZ
This is Ruby wrapper for [web service for "searching information about reliability of VAT payers and their bank accounts" of Czech Republic Ministry of finance.](http://www.etrzby.cz/cs/index)

## Installation
`gem install 'vat_payer_cz'`

## Official docs (in Czech)
https://adisspr.mfcr.cz/adistc/adis/idpr_pub/dpr_info/ws_spdph.faces

## Usage
The web service has the following three end-points:
- standard VAT payer info
- extended VAT payer info
- list of unreliable VAT payers

This gem currently implements 'standard VAT payer info'.

# Standard VAT payer info
```ruby
vat_ids = %w(CZ27169278 CZ26168685)
VatInfo.unreliable_payer(*vat_ids)
```
You should see something like this:
```shell
=> #<VatInfo::Response:0x0000000002756758
 @body=
  {:platci=>
    [{:nespolehlivy_platce=>"NE",
      :datum_zverejneni=>nil,
      :dic=>"CZ27169278",
      :cislo_fu=>"451",
      :ucty=>
       [{:predcisli=>nil, :cislo=>"1041150202", :kod_banky=>"5500", :iban=>nil, :datum_zverejneni=>"2013-04-01"},
        {:predcisli=>nil, :cislo=>"6021446666", :kod_banky=>"6000", :iban=>nil, :datum_zverejneni=>"2013-12-05"},
        {:predcisli=>nil, :cislo=>"2400915487", :kod_banky=>"2010", :iban=>nil, :datum_zverejneni=>"2016-05-05"}]}]},
 @status_code=200>
```
## Response
Object `VatInfo::Response`
### status_code
`VatInfo::Response.status_code => String`
200 - OK: Valid response was received.
408 - Request Timeout: the web service timed out.
503 - Service Unavailable: there was another error fetching the response.

### body
Empty attributes have `nil`.

`VatInfo::Response.body => Hash`
```ruby
{
  platci: [ { Payer }, .. ]
}
```
#### Payer
```ruby
{
  nespolehlivy_platce: String, # "ANO" | "NE" | "NENALEZEN"
  datum_zverejneni: String, #ISO 8601 Date,
  dic: String,
  cislo_fu: String,
  ucty: [ { Account }, .. ]
}
```
#### Account
```ruby
{
  predcisli: String # Czech account,
  cislo: String,
  kod_banky: String,
  iban: String
}
```

## Schema changes
The client will raise `VatInfo::SchemaError` exception if it thinks the schema have changed.

