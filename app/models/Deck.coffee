class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(1, 53)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: ->
    # @initialize if @length < 20
    console.log("There are #{@length-2} cards left")
    hand = new Hand [ @pop(), @pop() ], @


  dealDealer: ->
    # @initialize if @length < 20
    console.log("There are #{@length-2} cards left")
    new Hand [ @pop().flip(), @pop() ], @, true