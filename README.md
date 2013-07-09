# The Auction Sniper Example from Growing Object-Oriented Software Guided by Tests
## An Implementation in Ruby

## Setting Up the Infrastructure

You need an XMPP server running on localhost. I use *prosody*, which is simple
to setup. After installation, you need to create three users:

    sudo prosodyctl register sniper localhost sniper
    sudo prosodyctl register auction-item-54321 localhost auction
    sudo prosodyctl register auction-item-65432 localhost auction

and should disable the system service:

    sudo update-rc.d prosody disable

Then change `/etc/prosody/conf.d/localhost.cfg.lua` to look like this:

    -- Section for localhost
    daemonize = false
    log = {
      { to = "console" };
    }
    
    -- This allows clients to connect to localhost. No harm in it.
    VirtualHost "localhost"

All infrastructure services are started through foreman, so run `foreman start`.

## Terms

- *Item* is something that can be identified and bought
- *Bidder* is a person or organization that is interested in buying an item
- *Bid* is a statement that a bidder will pay a given price for an item
- *Current price* is the current highest bid for the item
- *Stop price* is the most a bidder is prepared to pay for the item
- *Auction* is a process for managing bids for an item
- *Auction house* is an institution that hosts auctions

## The Auction Protocol

Bidders send XMPP commands:

- *Join*: A bidder joins an auction. The *sender* of the XMPP message
  identifies the bidder, and the name of the chat session identifies the item.
- *Bid*: A bidder sends a bidding price to the auction.

Auctions send XMPP events:

- *Price*: An auction reports the currently accepted price. This event also
  includes the minimum increment that the next bid must be raised by, and the
  name of bidder who bid this price. The auction will send this event to a
  bidder when it joins and to all bidders whenever a new bid has been accepted.
- *Close*: An auction announces that it has closed. The winner of the last
  price event has won the auction.
