class App.Views.ChartView extends Backbone.View

  initialize: ->

    @width = @model.get('width')
    @height = @model.get('height')
    @yAxisAreaWidth = 100
    @dataWidth = @width - @yAxisAreaWidth
    @maxY = @model.get('maxY')
    @data = @model.get('data')

    @render()

    @model.on "change", => @transition()


  setScales: ->

    @maxY = @model.get('maxY')
    @data = @model.get('data')

    @scales =

      y: d3.scale.linear()
        .domain([0, @maxY])
        .range([0, @height])

      yAxis: d3.scale.linear()
        .domain([0, @maxY])
        .range([@height, 0])

    @yAxis = d3.svg.axis()
      .scale(@scales.yAxis)
      .orient("right")
      .ticks(3)


    @lineX = (d,i) => i * (@dataWidth / @data.length)
    @lineY = (d) => @height - @scales.y(d)

    @

  render: ->

    @setScales()

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

    @line = d3.svg.line()
      .x(@lineX)
      .y(@lineY)

    @svg.append("path")
        .attr("class", "line")
        .attr("d", @line(data))

    @

  transition: ->

    @setScales()

    @svg.selectAll("path").transition()
      .attr("d", @line(@model.get('data')))

    @svg.select(".axis")
      .transition()
      .call(@yAxis)