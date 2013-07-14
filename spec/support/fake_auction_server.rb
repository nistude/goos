require 'blather/client/dsl'

class FakeAuctionServer
  include Blather::DSL

  attr_reader :item_id

  AUCTION_PASSWORD = 'auction'
  XMPP_HOSTNAME = 'localhost'
  @@message_counter = 0

  def initialize(item_id)
    @item_id = item_id
  end

  def start_selling_item
    setup("auction-#@item_id@#{XMPP_HOSTNAME}", AUCTION_PASSWORD)

    message do |_|
      @@message_counter += 1
    end

    run
  end

  def announce_closed
    say 'sniper@localhost', 'Close'
  end

  def has_received_join_request_from_sniper?
    @@message_counter > 0
  end
end
