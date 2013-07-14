require 'spec_helper'
require 'support/application_runner'
require 'support/fake_auction_server'

feature 'AuctionSniper end-to-end test' do
  let(:auction) { FakeAuctionServer.new('item-54321') }
  let(:application) { ApplicationRunner.new }

  before(:each) do
    @em_thread = Thread.new { EM.run }
    while not EM.reactor_running?; end
  end

  scenario 'Sniper joins auction until auction closes' do
    auction.start_selling_item
    application.start_bidding_in(auction)
    application_shows_sniper_status(AuctionSniper::STATUS_JOINING)
    expect { auction.has_received_join_request_from_sniper? }.to become_true
    auction.announce_closed
    expect { application_shows_sniper_has_lost_auction }.to become_true
    auction.stop
    application.stop
  end

  after(:each) do
    EM.stop_event_loop if EM.reactor_running?
    @em_thread.join
  end

  def application_shows_sniper_status(status_text)
    visit '/'
    page.body.match(status_text)
  end

  def application_shows_sniper_has_lost_auction
    application_shows_sniper_status(AuctionSniper::STATUS_LOST)
  end
end
