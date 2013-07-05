require 'support/my_acceptance_dsl'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.include MyAcceptanceDSL
end
