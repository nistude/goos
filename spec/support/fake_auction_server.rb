require 'blather/client/client'

class FakeAuctionServer
  attr_reader :item_id

  AUCTION_PASSWORD = 'auction'
  XMPP_HOSTNAME = 'localhost'

  def initialize(item_id)
    @item_id = item_id
    @message_counter = 0
  end

  def start_selling_item
    @client = Blather::Client.setup("auction-#@item_id@#{XMPP_HOSTNAME}",
                                    AUCTION_PASSWORD)

    @client.register_handler(:message) do |_|
      @message_counter += 1
    end

    @client.run
  end

  def stop
    EM.next_tick { @client.close }
  end

  def announce_closed
    EM.next_tick do
      @client.write Blather::Stanza::Message.new('sniper@localhost', 'Close')
    end
  end

  def has_received_join_request_from_sniper?
    @message_counter > 0
  end
end
