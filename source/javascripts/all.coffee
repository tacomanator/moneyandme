#= require jquery
#= require underscore
#= require backbone
#= require lib/backbone.localStorage.js
#= require lib/backbone.collectionsubset.js
#= require lib/backbone.mutators.js
#= require lib/rivets.js
#= require lib/d3.v2.js
#= require lib/moment.js
#= require lib/moment-range.js
#= require config
#= require_tree .

jQuery ->

  model = new App.Models.Model(annualIncome: 100000, monthlyExpenses: 4000, percentSaved: 0.5)

  modelView = new App.Views.ModelView(model: model)

  $('#app-container').html(modelView.el)

  window.model = model