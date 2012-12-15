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
#= require lib/html5slider.js
#= require config
#= require_tree .

jQuery ->

  model = new App.Models.Model
    annualIncome: 90000
    monthlyExpenses: 5000
    percentSaved: 0.5
    yearsToSave: 20
    monthlyRate: 0.0066

  modelView = new App.Views.ModelView(model: model)

  $('#app-container').html(modelView.el)

  window.model = model