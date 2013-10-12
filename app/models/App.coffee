#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
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

    if dealerScore > 21
      @set 'endGameMsg', 'You WIN!'
    else if playerScore > dealerScore
      @set 'endGameMsg', 'You WIN!'
    else if playerScore < dealerScore
      @set 'endGameMsg', 'You LOSE!'
    else
      @set 'endGameMsg', 'You LOSE!'

    @trigger 'gameOver', @

  restart: ->
    @initialize() if @get('deck').length < 16
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()
    @set 'endGameMsg', null
    @get('playerHand').on 'stand', =>
      @endGame()
