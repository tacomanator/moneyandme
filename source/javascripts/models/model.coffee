class App.Models.Model extends Backbone.Model

  monthlyIncome: -> Math.round(@get('annualIncome') / 12)

  monthlyMaximumSavings: -> Math.round(@monthlyIncome()) - @get('monthlyExpenses')

  monthlyActualSavings: -> Math.round(@monthlyMaximumSavings() * @get('percentSaved'))

  fv: (rate, periods, payment) -> payment * (1 + rate) * ( ( Math.pow(periods, 1 + rate) - 1 ) / rate)