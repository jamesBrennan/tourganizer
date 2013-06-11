Tourganizer.Stops.IndexHotkeysMixin = ["$scope", "$q", ($scope, $q) ->
  $scope.saveEnabled = true

  #convenience methods
  listScope   = -> $('ul.stops').scope()
  selected    = -> listScope().selected()
  stops       = -> listScope().stops
  firstStop   = -> _.first stops()
  lastStop    = -> _.last stops()
  targetScope = (locals) -> $(locals.$event.target).scope()
  targetStop  = (locals) -> targetScope(locals).stop

  setFocus = (stop, element = "input:first") ->
    deferred = $q.defer()

    finder = if stop.id
      [element, ".stop-#{stop.id}"]
    else
      [element, ".stops li:last"]

    watch_count = 0

    cancelWatch = $scope.$watch ->
      if watch_count > 8
        deferred.reject("Could not set focus becaus #{watch_count} digest cycles passed without finding any elements at $(\"#{finder.join('\",\"')}\").")
        cancelWatch()
      else if ($(finder...).length && $(finder...).focus())
        deferred.resolve($(finder...))
        cancelWatch()
      else
        watch_count++

    deferred.promise

  select = (scope, locals) ->
    s = targetScope(locals)
    selectStop(s.stop) if s.stop && s.stops

  selectStop = (stop) ->
    _.each _.difference(stops(), [stop]), (_stop) ->
      _stop.selected = false
      _stop.editing = false
    stop.selected = true
    stop

  selectAndFocus = (stop, element = 'a:first') ->
    selectStop stop
    setFocus stop, element
    stop

  selectFirst = ->
    selectAndFocus firstStop()

  selectLast = ->
    selectAndFocus lastStop()

  selectPrev = ->
    stop = listScope().before selected()
    if stop then selectAndFocus(stop) else selectLast()

  selectNext = ->
    stop = listScope().after selected()
    if stop then selectAndFocus(stop) else selectFirst()

  newStop = (scope) ->
    scope.editing = true
    stop = listScope().addStop()
    selectAndFocus stop, 'input:first'

  edit = (scope, locals) ->
    scope.editing = true
    stop = targetStop(locals)
    stop.editing = true
    setFocus stop

  cancelEdit = (scope, locals) ->
    scope.editing = false
    stop = targetStop(locals)
    return unless stop
    stop.editing = false
    stops().pop() unless stop.id
    selectAndFocus stop

  saveEdit = (scope, locals) ->
    locals.$event.preventDefault();
    if $scope.saveEnabled
      s = targetScope(locals)
      s.listSave(s.stop)

  deleteStop = (scope, locals) ->
    locals.$event.stopImmediatePropagation();
    $scope.saveEnabled = false
    s = targetScope(locals)
    s.destroy(s.stop)
    $scope.saveEnabled = true

  $scope.keymap =
    keyup:
      'tab':
        fn: select
      'shift-tab':
        fn: select
      'alt-78': #n
        fn: newStop
      '69': #e
        fn: edit
      'alt-68': #d
        fn: deleteStop
      'alt-83': #s
        fn: saveEdit
        active_on_edit: true
      'alt-76': #l
        fn: selectLast
      'alt-70': #f
        fn: selectFirst
      'esc':
        fn: cancelEdit
        active_on_edit: true
    keypress:
      'up':
        fn: selectPrev
      'down':
        fn: selectNext
]

