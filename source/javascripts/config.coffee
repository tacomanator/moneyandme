_.templateSettings =
  interpolate: /\{\{=(.+?)\}\}/g
  evaluate: /\{\{(.+?)\}\}/g

rivets.configure(
  adapter:
    subscribe: (obj, keypath, callback) ->
      obj.on('change:' + keypath, callback)
    unsubscribe: (obj, keypath, callback) ->
      obj.off('change:' + keypath, callback)
    read: (obj, keypath) ->
      obj.get(keypath)
    publish: (obj, keypath, value) ->
      obj.set(keypath, value)
)

rivets.formatters.money = (value) ->
  accounting.formatMoney value, "$", 0

rivets.formatters.percent = (value) ->
  "#{value * 100}%"

window.App = {}
window.App.Models = {}
window.App.Collections = {}
window.App.Views = {}