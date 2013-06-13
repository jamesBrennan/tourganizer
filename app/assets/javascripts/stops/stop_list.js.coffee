class Tourganizer.Stops.StopList
  constructor: (@scope)->
    @stops = @scope.stops

  editing: ->
    _.find @stops, (stop) ->
      stop.editing == true

  remove: (stop) ->
    idx = @stops.indexOf(stop)
    @stops.splice(idx,1)

  selected: ->
    _.filter @stops, (stop) -> stop.selected

  find: (id) ->
    _.find @stops, (stop) -> stop.id == id

  selectOnly: (stop) ->
    @last_selected = undefined
    _.each _.difference(@stops, [stop]), (_stop) ->
      _stop.selected = false
      _stop.editing = false
    stop.selected = true
    stop

  select: (stop) -> stop.selected = true
  deselect: (stop) -> stop.selected = false
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

  beforeSelection: ->
    @before _.first @selected()

  afterSelection: ->
    @after _.last @selected()

  closerToRoot: (stop) ->
    return false unless @select_root && @last_selected
    si = @stops.indexOf(stop)
    ri = @stops.indexOf(@select_root)
    li = @stops.indexOf(@last_selected)
    dir = if si - li > 0 then 'asc' else 'desc'
    (ri < si && dir == 'desc') || (ri > si && dir == 'asc')
