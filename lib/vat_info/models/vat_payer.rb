module VatInfo
  module Models
    class VatPayer
      attr_accessor :data

      def initialize(params)
        @data                       = {}
        @data[:nespolehlivy_platce] = params.fetch(:@nespolehlivy_platce)
        @data[:dic]                 = params.fetch(:@dic)
        @data[:cislo_fu]            = params.fetch(:@cislo_fu, nil)
        accounts                    = params.fetch(:zverejnene_ucty, nil)
        @data[:ucty]                = create_accounts(accounts[:ucet]) if accounts
      end

      def create_accounts(accounts)
        accounts.map do |account|
          standard     = account.fetch(:standardni_ucet, nil)
          non_standard = account.fetch(:nestandardni_ucet, nil)

          params = if standard
                     {
                       cislo: standard.fetch(:@cislo, nil),
                       kod_banky: standard.fetch(:@kod_banky, nil),
                       iban: nil
                     }
                   else
                     { cislo: nil,
                       kod_banky: nil,
                       iban: non_standard.fetch(:@cislo, nil)
                     }
                   end

          params.merge(datum_zverejneni: account[:@datum_zverejneni])
        end
      end
    end
  end
end
