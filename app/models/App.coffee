#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', =>
      @endGame()

  endGame: ->
    playerScore = @get('playerHand').scores()[0]

    if playerScore < @get('playerHand').scores()[1] < 21
      playerScore = @get('playerHand').scores()[1]

    return console.log('the player busts, dealer wins') if playerScore > 21

    dealerHand = @get('dealerHand')
    dealerHand.first().flip()

    dealerHand.hit() while @get('dealerHand').scores()[0] < 17
    dealerScore = @get('dealerHand').scores()[0]

    if dealerScore > 21
      console.log("the player wins with a score of #{playerScore}")
    if playerScore > dealerScore
      console.log("the player wins with a #{playerScore}")
    else if playerScore < dealerScore
      console.log("the dealer wins with a #{dealerScore}")
    else
      console.log("the house wins because it was a draw")

  # restart: ->