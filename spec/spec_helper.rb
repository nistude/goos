require 'support/my_acceptance_dsl'
require 'support/matchers'
require 'capybara/rspec'

require 'auction_sniper'
require 'auction_sniper/web_ui'

Capybara.app = AuctionSniper::WebUI

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.include MyAcceptanceDSL
end
