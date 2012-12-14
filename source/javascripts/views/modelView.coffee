class App.Views.ModelView extends Backbone.View

  template: _.template($('#model-template').html())

  initialize: ->

    @chart =
      initialized: false

    @render()


  render: ->

    $(@el).html(@template(@model.toJSON()))

    _.defer => rivets.bind($('body'), {model: @model})

    @model.on "change", => @drawChart()

    @drawChart()

    @


  initializeChart: ->

    @setChartData()

    _.defer => # to ensure width is "ready"

      @chart.padding = 10
      @chart.barPadding = 1
      @chart.yAxisAreaWidth = 75

      bodyPadding = parseInt($('body').css('padding-top'))*2
      @chart.height = $(window).height() - bodyPadding

      @chart.width = $(@el).find('svg').width()
      @chart.dataWidth = @chart.width - @chart.yAxisAreaWidth - @chart.padding
      @chart.dataHeight = @chart.height - @chart.padding

      @chart.view = d3.select(@el).select('svg')
        .attr("height", @chart.height)
        .attr("width", @chart.width)

      @chart.barX = (d,i) => i * (@chart.dataWidth / @chart.data.length)
      @chart.barY = (d,i) => @chart.dataHeight - @chart.scale(d)
      @chart.barH = (d,i) => @chart.scale(d)
      @chart.barW = () => @chart.dataWidth / @chart.data.length - @chart.barPadding

      @chart.initialized = true

      @chart.view.append("g")
        .attr("class", "axis")
        .attr("transform", "translate(#{@chart.width-@chart.yAxisAreaWidth},0)")
        .attr("height", @chart.dataHeight)
        .call(@chart.yAxis)

  setChartData: ->

    years = 10
    rate = 0.6434
    monthlySavings = @model.monthlyPotentialSavings()

    @chart.data = [1..(12*years)].map (month) ->
      monthlySavings * (1 + rate) * ( ( Math.pow(month, 1 + rate) - 1 ) / rate)

    @chart.scale = d3.scale.linear()
      .domain([0, d3.max(@chart.data)])
      .range([0, @chart.dataHeight])

    @chart.axisScale = d3.scale.linear()
      .domain([0, d3.max(@chart.data)])
      .range([@chart.dataHeight, 0])

    @chart.yAxis = d3.svg.axis()
      .scale(@chart.axisScale)
      .orient("right")
      .ticks(3)


  drawChart: ->

    @initializeChart() unless @chart.initialized
    
    _.defer =>

      @setChartData()

      @chart.view.select(".axis")
        .transition()
        .call(@chart.yAxis)

      rect = @chart.view.selectAll("rect")
        .data(@chart.data)

      rect.enter()
        .append("rect")
        .attr("width", @chart.barW)
        .attr("height", @chart.barH)
        .attr("x", @chart.barX)
        .attr("y", @chart.barY)
        .attr("fill", @chart.barFill)
      
      rect.transition()
        .duration(500)
        .attr("height", @chart.barH)
        .attr("y", @chart.barY)