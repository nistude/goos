require 'blather/client/dsl'

class AuctionSniper
  include Blather::DSL

  STATUS_JOINING = 'joining'
  STATUS_LOST = 'lost'
  @@status = STATUS_JOINING

  def self.status
    @@status
  end

  def start(xmpp_hostname, sniper_id, sniper_password, item_id)
    setup("#{sniper_id}@#{xmpp_hostname}", sniper_password)

    when_ready do
      say "auction-#{item_id}@#{xmpp_hostname}", 'Join'
    end

    message do |_|
      @@status = STATUS_LOST
    end

    run
  end
end
