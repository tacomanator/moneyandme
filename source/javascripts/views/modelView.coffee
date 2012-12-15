class App.Views.ModelView extends Backbone.View

  template: _.template($('#model-template').html())

  initialize: ->
    @render()

  render: ->

    $(@el).html(@template(@model.toJSON()))

    chartContainer = $(@el).find('#chart-container')

    _.defer =>

      rivets.bind($('body'), {model: @model})

      w = chartContainer.width()
      h = $(window).height() - chartContainer.offset().top * 2

      @chart = new App.Models.Chart width: w, height: h
      @setChartData()

      @chartView = new App.Views.ChartView model: @chart, el: chartContainer.find('svg')
      chartContainer.append(@chartView.el)

      @model.on "change", => @setChartData()

  setChartData: ->

    years = 10
    rate = 0.6434
    monthlySavings = @model.monthlyActualSavings()
    data = [1..(12*years)].map (month) ->
      monthlySavings * (1 + rate) * ( ( Math.pow(month, 1 + rate) - 1 ) / rate)
    @chart.set('data', data)