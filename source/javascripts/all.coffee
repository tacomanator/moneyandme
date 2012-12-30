#= require jquery
#= require underscore
#= require lib/backbone/backbone.js
#= require bootstrap-tab
#= require lib/rivets.js
#= require lib/d3.v2.js
#= require lib/accounting.js
#= require lib/modernizr.custom.js
#= require lib/backbone-deep-model/lib/underscore.mixin.deepExtend
#= require lib/backbone-deep-model/src/deep-model.js
#= require config
#= require_tree ./models
#= require_tree ./views

jQuery ->

  financialModel = new App.Models.FinancialModel
    annualIncome: 90000
    monthlyExpenses: 5000
    percentSaved: 0.5
    yearsToSave: 20
    annualRateOfReturn: .08
    retirementAnnualRateOfReturn: 0.04
    retirement:
      need: 0.80

  appView = new App.Views.AppView(model: financialModel)

  $('#app-container').html(appView.el)

  $('#form-selection-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab('show')

