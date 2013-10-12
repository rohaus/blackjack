#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  endGame: ->
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    if playerScore > 21
      console.log('the player busts, dealer wins')
    else if playerScore > dealerScore
      console.log('the player wins')
    else if playerScore < dealerScore
      console.log('the dealer wins')
    else
      console.log('the house wins')

  # restart: ->