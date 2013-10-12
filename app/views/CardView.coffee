class window.CardView extends Backbone.View

  className: 'card'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.css({
      'background-image': "url(assets/#{@model.get('rankName')}-#{@model.get('suitName')}.png)"
    })
    @$el.children().detach().end().html
    @$el.css('background-image','url(assets/card-back.png)') unless @model.get 'revealed'
