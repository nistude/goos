require 'sinatra/base'

class AuctionSniper::WebUI < Sinatra::Base
  get '/' do
    sniper.status
  end

  def sniper
    settings.sniper
  end
end
