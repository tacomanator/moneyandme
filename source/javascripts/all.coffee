#= require jquery
#= require underscore
#= require backbone
#= require bootstrap-modal
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
  console.log('ready... now write me some javascript')


  model = new App.Models.Model
  modelView = new App.Views.ModelView(model:model)
  $('#app-container').html(modelView.el)