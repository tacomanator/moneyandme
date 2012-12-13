class App.Views.ModelView extends Backbone.View

  template: _.template($('#model-template').html())

  initialize: ->

    @chart =
      initialized: false
    @render()

  render: ->

    $(@el).html(@template(@model.toJSON()))
    @drawChart()
    @

  initializeChart: ->

    _.defer => # to ensure width is "ready"

      bodyPadding = parseInt($('body').css('padding-top'))*2
      @chart.width = $(@el).find('svg').width()
      @chart.height = $(window).height() - bodyPadding

      @chart.view = d3.select(@el).select('svg')
        .attr("height", @chart.height)
        .attr("width", @chart.width)

      @chart.initialized = true

  drawChart: ->
    @initializeChart() unless @chart.initialized