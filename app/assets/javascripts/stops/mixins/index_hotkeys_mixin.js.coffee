Tourganizer.Stops.IndexHotkeysMixin = ["$scope", ($scope) ->
  $scope.saveEnabled = true

  targetScope = (locals) ->
    $(locals.$event.target).scope()

  setFocus = (stop, element = "input:first") ->
    finder = if stop.id
      [element, ".stop-#{stop.id}"]
    else
      [element, ".stops li:last"]
    watch_count = 0
    cancelWatch = $scope.$watch ->
      cancelWatch() if watch_count > 10 || ($(finder...).length && $(finder...).focus())
      watch_count++

  select = (scope, locals) ->
    s = targetScope(locals)
    selectStop(s.stop, s.stops) if s.stop && s.stops

  selectStop = (stop, stops) ->
    _.each _.difference(stops, [stop]), (_stop) ->
      _stop.selected = false
      _stop.editing = false
    stop.selected = true

  selectFirst = () ->
    scope = $('ul.stops').scope()
    stop = _.first(scope.stops)
    selectStop(stop, scope.stops)
    setFocus(stop, 'a:first')

  selectLast = () ->
    scope = $('ul.stops').scope()
    stop = _.last(scope.stops)
    selectStop(stop, scope.stops)
    setFocus(stop, 'a:first')

  newStop = () ->
    stop = $('ul.stops').scope().addStop()
    setFocus(stop)

  edit = (scope, locals) ->
    s = targetScope(locals)
    s.stop.editing = true
    setFocus(s.stop)

  cancelEdit = (scope, locals) ->
    s = targetScope(locals)
    s.stop.editing = false
    setFocus(s.stop, "a:first")

  saveEdit = (scope, locals) ->
    locals.$event.preventDefault();
    if $scope.saveEnabled
      s = targetScope(locals)
      s.listSave(s.stop,)

  deleteStop = (scope, locals) ->
    locals.$event.stopImmediatePropagation();
    $scope.saveEnabled = false
    s = targetScope(locals)
    s.destroy(s.stop)
    $scope.saveEnabled = true

  $scope.keymap =
    'tab': select
    'shift-tab': select
    'alt-78': newStop #n
    'alt-69': edit #e
    'alt-68': deleteStop #d
    'alt-83': saveEdit #s
    'alt-76': selectLast #l
    'alt-70': selectFirst #f
    'esc': cancelEdit
]

