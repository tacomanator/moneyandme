class App.Models.Model extends Backbone.Model

  monthlyIncome: -> Math.round(@get('annualIncome') / 12)

  monthlyMaximumSavings: -> Math.round(@monthlyIncome()) - @get('monthlyExpenses')

  monthlyActualSavings: -> Math.round(@monthlyMaximumSavings() * @get('percentSaved'))

  fv: (r, n, payment) ->
    Math.round(payment * ( Math.pow(1 + r, n) - 1 ) / r)