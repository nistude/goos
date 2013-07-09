require 'spec_helper'
require 'support/application_runner'
require 'support/fake_auction_server'

feature 'AuctionSniper end-to-end test' do
  let(:auction) { FakeAuctionServer.new('item-54321') }
  let(:application) { ApplicationRunner.new }

  before(:each) do
    Thread.new do
      EM.run do
        auction.start_selling_item
        application.start_bidding_in(auction)
      end
    end
    while not EM.reactor_running?; end
    while not auction.started? and not application.started?
      sleep 0.1
    end
  end

  scenario 'Sniper joins auction until auction closes' do
    application_shows_sniper_status(AuctionSniper::STATUS_JOINING)
    expect { auction.has_received_join_request_from_sniper? }.to become_true
    auction.announce_closed
    expect { application_shows_sniper_has_lost_auction }.to become_true
  end

  def application_shows_sniper_status(status_text)
    visit '/'
    page.body.match(status_text)
  end

  def application_shows_sniper_has_lost_auction
    application_shows_sniper_status(AuctionSniper::STATUS_LOST)
  end
end
