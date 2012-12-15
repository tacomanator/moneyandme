class App.Views.ModelView extends Backbone.View

  template: _.template($('#model-template').html())

  initialize: ->
    @render()

  render: ->

    $(@el).html(@template(@model.toJSON()))

    _.defer =>

      rivets.bind($('body'), {model: @model})

      if Modernizr.inlinesvg

        chartContainer = $(@el).find('#chart-container')

        w = chartContainer.width()
        h = $(window).height() - chartContainer.offset().top * 2

        @chart = new App.Models.Chart width: w, height: h
        @setupChart()

        @chartView = new App.Views.ChartView model: @chart, el: chartContainer.find('svg')
        chartContainer.append(@chartView.el)

        @model.on "change", => @setupChart()

  setupChart: ->

    years = @model.get 'yearsToSave'
    totalMonths = years * 12
    rate = @model.monthlyRateOfReturn()

    monthlyMaxiumumSavings = @model.monthlyMaximumSavings()
    monthlyActualSavings = @model.monthlyActualSavings()

    maximumFutureValue = @model.fv(rate, totalMonths, monthlyMaxiumumSavings)

    @chart.set 'maxY', maximumFutureValue

    data = [1..totalMonths].map (month) =>
      @model.fv(rate, month, monthlyActualSavings)

    @chart.set 'data', data

    @