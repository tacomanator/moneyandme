class App.Views.ModelView extends Backbone.View

  template: _.template($('#model-template').html())

  initialize: ->
    @render()
    @rate = 0.6434
    @years = 10

  render: ->

    $(@el).html(@template(@model.toJSON()))

    chartContainer = $(@el).find('#chart-container')

    _.defer =>

      rivets.bind($('body'), {model: @model})

      w = chartContainer.width()
      h = $(window).height() - chartContainer.offset().top * 2
      maxY = @model.fv(@rate, @years*12, @model.monthlyMaximumSavings())

      @chart = new App.Models.Chart width: w, height: h
      @resetChart()

      @chartView = new App.Views.ChartView model: @chart, el: chartContainer.find('svg')
      chartContainer.append(@chartView.el)

      @model.on "change:annualIncome change:monthlyExpenses", => @resetChart()
      @model.on "change:percentSaved", => @chart.set('data', @chartData())

  chartData: ->

    monthlySavings = @model.monthlyActualSavings()
    [1..(12*@years)].map (month) =>
      @model.fv(@rate, month, monthlySavings)

  resetChart: ->

    @chart.set('maxY', @model.fv(@rate, @years*12, @model.monthlyMaximumSavings()))
    @chart.set('data', @chartData())

