class App.Views.preRetirementFormView extends Backbone.View

  template: _.template($('#pre-retirement-form-template').html())
  className: 'tab-pane active'
  id: 'pre-retirement'

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @