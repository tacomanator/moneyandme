#= require jquery
#= require underscore
#= require backbone
#= require bootstrap-tab
#= require lib/rivets.js
#= require lib/d3.v2.js
#= require lib/accounting.js
#= require lib/modernizr.custom.js
#= require config
#= require_tree .

jQuery ->

  financialModel = new App.Models.FinancialModel
    annualIncome: 90000
    monthlyExpenses: 5000
    percentSaved: 0.5
    yearsToSave: 20
    annualRateOfReturn: .08


  appView = new App.Views.AppView(model: financialModel)

  $('#app-container').html(appView.el)

  $('#form-selection-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab('show')

