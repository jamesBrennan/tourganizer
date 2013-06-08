Tourganizer.Stops.StopBehaviorMixin = ['$q', (stop, $q) ->
  _.extend stop.prototype,
    select: ->
      @selected = true
    deselect: ->
      @selected = false
]
