class App.Views.FormView extends Backbone.View

  template: _.template($('#form-template').html())
  
  initialize: ->
    @render()

  render: ->

    $(@el).html(@template(@model.toJSON()))