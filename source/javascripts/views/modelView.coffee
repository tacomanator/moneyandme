class App.Views.ModelView extends Backbone.View

  initialize: ->
    @render()

  render: ->

    @summaryView = new App.Views.SummaryView model: @model, el: $('#summary')
    @formView = new App.Views.FormView model: @model, el: $('#variables')
    @chartView = new App.Views.ChartView model: @model, el: $('#chart')

    unless Modernizr.inlinesvg
      $('#chart').html("<p>Chart not supported by your browser (SVG)</p>")

    rivets.bind($('body'), {model: @model})

    @