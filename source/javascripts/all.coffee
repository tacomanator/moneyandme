#= require jquery
#= require underscore
#= require backbone
#= require lib/rivets.js
#= require lib/d3.v2.js
#= require lib/accounting.js
#= require lib/modernizr.custom.js
#= require config
#= require_tree .

jQuery ->

  model = new App.Models.Model
    annualIncome: 90000
    monthlyExpenses: 5000
    percentSaved: 0.5
    yearsToSave: 20
    annualRateOfReturn: .08

  modelView = new App.Views.ModelView(model: model)

  $('#app-container').html(modelView.el)

  window.model = model