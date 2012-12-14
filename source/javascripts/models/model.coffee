class App.Models.Model extends Backbone.Model
  monthlyIncome: -> Math.round(@get('annualIncome') / 12)
  monthlyPotentialSavings: -> Math.round(@monthlyIncome()) - @get('monthlyExpenses')
