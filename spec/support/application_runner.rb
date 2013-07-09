require 'auction_sniper'

class ApplicationRunner
  SNIPER_ID = 'sniper'
  SNIPER_PASSWORD = 'sniper'
  XMPP_HOSTNAME = 'localhost'

  def initialize
    @sniper = AuctionSniper.new
  end

  def start_bidding_in(auction)
    @sniper.start(XMPP_HOSTNAME, SNIPER_ID, SNIPER_PASSWORD, auction.item_id)
  end

  def started?
    @sniper.started?
  end
end
