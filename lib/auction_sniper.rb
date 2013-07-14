require 'blather/client/client'

class AuctionSniper
  STATUS_JOINING = 'joining'
  STATUS_LOST = 'lost'

  def initialize
    @status = STATUS_JOINING
    WebUI.set :sniper, self
  end

  def status
    @status
  end

  def start(xmpp_hostname, sniper_id, sniper_password, item_id)
    @client = Blather::Client.setup("#{sniper_id}@#{xmpp_hostname}",
                                    sniper_password)

    @client.register_handler(:ready) do
      EM.next_tick do
        @client.write Blather::Stanza::Message.new("auction-#{item_id}@#{xmpp_hostname}",
                                                   'Join')
      end
    end

    @client.register_handler(:message) do |_|
      @status = STATUS_LOST
    end

    @client.run
  end

  def stop
    EM.next_tick { @client.close }
  end
end
