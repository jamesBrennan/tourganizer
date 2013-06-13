class Tourganizer.Stops.StopList
  constructor: (@scope)->
    @stops = @scope.stops

  editing: ->
    _.find @stops, (stop) -> stop.editing

  remove: (stop) ->
    idx = @stops.indexOf(stop)
    @stops.splice(idx,1)

  selected: ->
    _.find @stops, (stop) -> stop.selected

  select: (stop) ->
    _.each _.difference(@stops, [stop]), (_stop) ->
      _stop.selected = false
      _stop.editing = false
    stop.selected = true
    stop

  first: -> _.first(@stops)
  last: -> _.last(@stops)

  cleanup: ->
    _.each @stops, (stop) => @remove(stop) unless stop.id

  before: (stop) ->
    idx = @stops.indexOf(stop)
    return null if idx == 0
    @stops[idx-1]

  after: (stop) ->
    idx = @stops.indexOf(stop)
    return null if idx == @stops.length - 1
    @stops[idx+1]
