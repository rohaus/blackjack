#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    console.log("Shuffling cards, there is a new deck")
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'endGameMsg', null
    @get('playerHand').on 'stand', =>
      @endGame()

  endGame: ->
    playerScore = @get('playerHand').scores()[0]

    if playerScore < @get('playerHand').scores()[1] <= 21
      playerScore = @get('playerHand').scores()[1]

    if playerScore > 21
      @set 'endGameMsg', 'You LOSE!'
      return @trigger 'gameOver', @

    dealerHand = @get('dealerHand')
    dealerHand.first().flip()

    dealerScore = @get('dealerHand').scores()[0]
    if dealerScore < @get('dealerHand').scores()[1] < 21
        dealerScore = @get('dealerHand').scores()[1]

    while dealerScore < 17
      dealerHand.hit()
      dealerScore = @get('dealerHand').scores()[0]
      if dealerScore < @get('dealerHand').scores()[1] < 21
        dealerScore = @get('dealerHand').scores()[1]

    console.log('player',playerScore,'dealer',dealerScore);

    if dealerScore > 21
      @set 'endGameMsg', 'You WIN!'
      console.log("the player wins with a score of #{playerScore}")
    else if playerScore > dealerScore
      @set 'endGameMsg', 'You WIN!'
      console.log("the player wins with a #{playerScore}")
    else if playerScore < dealerScore
      @set 'endGameMsg', 'You LOSE!'
      console.log("the dealer wins with a #{dealerScore}")
    else
      @set 'endGameMsg', 'You LOSE!'
      console.log("the house wins because it was a draw")

    @trigger 'gameOver', @

  restart: ->
    @initialize() if @get('deck').length < 16
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'endGameMsg', null
    @get('playerHand').on 'stand', =>
      @endGame()
