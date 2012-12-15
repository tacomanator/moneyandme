class App.Views.ChartView extends Backbone.View

  initialize: ->

    width = @model.get('width')
    height = @model.get('height')
    data = @model.get('data')
    yAxisAreaWidth = 100
    dataWidth = width - yAxisAreaWidth

    @lineX = (d,i) => i * (dataWidth / data.length)
    @lineY = (d) => height - @scales.y(d)

    @render()

  initialRender: ->

    yAxisAreaWidth = 100
    width = @model.get('width')
    height = @model.get('height')
    data = @model.get('data')

    @svg = d3.select(@el)
      .attr("width", width)
      .attr("height", height)
     
    @svg.append("g")
      .attr("class", "axis")
      .attr("transform", "translate(#{width - yAxisAreaWidth}, 0)")
      .attr("height", height)
      .call(@yAxis)

    @

  setScales: ->

    height = @model.get('height')
    data = @model.get('data')

    @scales =

      y: d3.scale.linear()
        .domain([0, @model.get('maxY')])
        .range([0, @model.get('height')])

      yAxis: d3.scale.linear()
        .domain([0, @model.get('maxY')])
        .range([height, 0])

    @yAxis = d3.svg.axis()
      .scale(@scales.yAxis)
      .orient("right")
      .ticks(3)

    @

  render: ->

    @setScales()

    @initialRender() unless @svg

    @line = d3.svg.line()
      .x(@lineX)
      .y(@lineY)

    @svg.append("path")
        .attr("class", "line")
        .attr("d", @line(@model.get('data')))

    @model.on "change", => @transition()

  transition: ->

    @setScales()

    @svg.selectAll("path").transition()
      .duration(500)
      .attr("d", @line(@model.get('data')))

    @svg.select(".axis")
      .transition()
      .call(@yAxis)