class App.Models.FinancialModel extends Backbone.DeepModel

  monthlyIncome: ->
    Math.round(@get('annualIncome') / 12)

  monthlyMaximumSavings: ->
    Math.round(@monthlyIncome()) - @get('monthlyExpenses')

  monthlyActualSavings: ->
    Math.round(@monthlyMaximumSavings() * @get('percentSaved'))

  monthlyLivingIncome: ->
    @monthlyIncome() - @monthlyActualSavings()

  monthlyRateOfReturn: ->
    Math.round( @get('annualRateOfReturn') / 12 * 10000 ) / 10000

  retirementMonthlyDraw: ->
    @monthlyLivingIncome() * @get('retirement.need')

  fv: (r, n, payment) ->
    Math.round(payment * ( Math.pow(1 + r, n) - 1 ) / r)

  totalSaved: ->
    @fv(@monthlyRateOfReturn(), @get('yearsToSave') * 12, @monthlyActualSavings())

  monthsItWillLast: (monthlyInterestRate, beginningBalance, monthlyWithdrawlAmount) ->
    i = monthlyInterestRate
    b = beginningBalance
    w = monthlyWithdrawlAmount
    j = 1 + i
    Math.log(w) / Math.log(j) - Math.log(w - b*i) / Math.log(j)