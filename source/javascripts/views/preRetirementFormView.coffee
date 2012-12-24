class App.Views.preRetirementFormView extends Backbone.View

  template: _.template($('#pre-retirement-form-template').html())
  className: '.tab-pane'
  id: 'post-retirement'
  
  initialize: ->
    @render()

  render: ->
    @