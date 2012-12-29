class App.Views.SummaryView extends Backbone.View

  template: _.template($('#summary-template').html())
  
  initialize: ->
    @render()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @