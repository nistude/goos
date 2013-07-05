# The Auction Sniper Example from Growing Object-Oriented Software Guided by Tests
## An Implementation in Ruby

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
