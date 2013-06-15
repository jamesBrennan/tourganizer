class Tourganizer.Stops.StopList
  constructor: (@scope)->
    @stops = @scope.stops

  editing: ->
    _.find @stops, (stop) ->
      stop.editing == true

  remove: (stop) ->
    idx = @stops.indexOf(stop)
    @stops.splice(idx,1)

  find: (id) ->
    _.find @stops, (stop) -> stop.id == id

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