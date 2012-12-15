class App.Views.ChartView extends Backbone.View

  initialize: ->

    @width = @model.get('width')
    @height = @model.get('height')

    @marginLeft = 5

    @yAxisAreaWidth = 80
    @dataWidth = @width - @yAxisAreaWidth - @marginLeft

    @xAxisAreaHeight = 30
    @dataHeight = @height - @xAxisAreaHeight

    @maxY = @model.get('maxY')

    @data = @model.get('data')

    @svg = d3.select(@el)
      .attr("width", @width)
      .attr("height", @height)

    @svg.append("svg:line")
      .attr("x1", @marginLeft)
      .attr("y1", 0)
      .attr("x2", @dataWidth+@marginLeft)
      .attr("y2", 0)

    @svg.append("svg:line")
      .attr("x1", @marginLeft)
      .attr("y1", 0)
      .attr("x2", @marginLeft)
      .attr("y2", @dataHeight)

    @render()

    @model.on "change", => @transition()


  setScales: ->

    @maxY = @model.get('maxY')
    @data = @model.get('data')
    @years = @model.get('yearsToSave')

    @scales =

      y: d3.scale.linear()
        .domain([0, @maxY])
        .range([@xAxisAreaHeight, @height])

      xAxis: d3.scale.linear()
        .domain([0, @data.length])
        .range([0, @dataWidth])

      yAxis: d3.scale.linear()
        .domain([0, @maxY])
        .range([@dataHeight, 0])

    @xAxis = d3.svg.axis()
      .scale(@scales.xAxis)
      .orient("bottom")

    @yAxis = d3.svg.axis()
      .scale(@scales.yAxis)
      .orient("right")

    @lineX = (d,i) => i * (@dataWidth / @data.length) + @marginLeft
    @lineY = (d) => @height - @scales.y(d)

    @

  render: ->

    @setScales()

    @svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(#{@marginLeft}, #{@height - @xAxisAreaHeight})")
      .call(@xAxis)

    @svg.append("g")
      .attr("class", "y axis")
      .attr("transform", "translate(#{@width - @yAxisAreaWidth}, 0)")
      .call(@yAxis)

    @line = d3.svg.line()
      .x(@lineX)
      .y(@lineY)

    @path = @svg.append("path")
      .attr("class", "line")
      .attr("d", @line(@data))

    @

  transition: ->

    @setScales()
    
    @path.transition()
      .attr("d", @line(@model.get('data')))

    @svg.select(".x.axis")
      .transition()
        .ease("linear")
      .call(@xAxis)

    @svg.select(".y.axis")
      .transition()
        .ease("linear")
      .call(@yAxis)