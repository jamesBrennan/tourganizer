class Tourganizer.Stops.StopList
  constructor: (@scope, $injector) ->
    console.log 'constructing stoplist on', @scope
    @stops = @scope.stops
    console.log '@stops', @stops
    console.log 'adding stop behavior to stops'
    _.each @stops, (stop) -> $injector.invoke(Tourganizer.Stops.StopBehaviorMixin, @, stop: stop)
    console.log 'stop behavior added'
    
  editing: ->
    _.find @stops, (stop) ->
      stop.editing == true

  remove: (stops) ->
    for stop in stops
      idx = @stops.indexOf(stop)
      @stops.splice(idx,1)

  find: (id) ->
    _.find @stops, (stop) -> stop.id == id

  first: -> _.first(@stops)
  last: -> _.last(@stops)

  cleanup: ->
    _.each @stops, (stop) => @remove([stop]) unless stop.id

  before: (stop) ->
    idx = @stops.indexOf(stop)
    return null if idx == 0
    @stops[idx-1]

  after: (stop) ->
    idx = @stops.indexOf(stop)
    return null if idx == @stops.length - 1
    @stops[idx+1]

Tourganizer.Stops.StopList.$inject = ["scope", "$injector"]
angular.module('stops').factory 'StopList', Tourganizer.Stops.StopList
