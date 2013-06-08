Tourganizer.Stops.IndexHotkeysMixin = ["$scope", ($scope) ->
  $scope.saveEnabled = true

  targetScope = (locals) ->
    $(locals.$event.target).scope()

  setFocus = (stop, element = "input:first") ->
    finder = if stop.id
      [element, ".stop-#{stop.id}"]
    else
      [element, ".stops li:last"]
    cancelWatch = $scope.$watch ->
      if $(finder...).length
        $(finder...).focus()
        cancelWatch()

  select = (scope, locals) ->
    s = targetScope(locals)
    if s.stop && s.stops
      _.each _.difference(s.stops, [s.stop]), (stop) ->
        stop.selected = false
        stop.editing = false
      s.stop.selected = true

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
    'esc': cancelEdit
]

