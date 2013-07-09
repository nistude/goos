require 'sinatra'

class AuctionSniper::WebUI < Sinatra::Base
  get '/' do
    AuctionSniper.status
  end
end
