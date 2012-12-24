class App.Views.postRetirementFormView extends Backbone.View

  template: _.template($('#post-retirement-form-template').html())
  className: '.tab-pane'
  id: 'post-retirement'

  initialize: ->
    @render()

  render: ->
    @