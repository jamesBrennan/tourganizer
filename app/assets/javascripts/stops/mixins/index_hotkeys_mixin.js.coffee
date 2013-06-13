Tourganizer.Stops.StopsHotkeysMixin = ["$scope", "$q", ($scope, $q) ->

  #convenience methods
  listScope   = -> $('table.stops').scope()
  selected    = -> listScope().selected()
  stops       = -> listScope().stoplist
  targetScope = (locals) -> $(locals.$event.target).scope()

  select = (scope, locals) ->
    s = targetScope(locals)
    stops().select(s.stop) if s.stop && s.stops

  selectAndFocus = (stop) ->
    stops().select stop
    listScope().focus(stop)
    stop

  selectFirst = ->
    selectAndFocus stops().first()

  selectLast = ->
    selectAndFocus stops().last()

  selectPrev = ->
    stop = listScope().before selected()
    if stop then selectAndFocus(stop) else selectLast()

  selectNext = ->
    stop = listScope().after selected()
    if stop then selectAndFocus(stop) else selectFirst()

  newStop = ->
    stop = listScope().addStop()
    selectAndFocus stop

  states =
    navigating:
      keyup:
        'tab': select
        'shift-tab': select
        '78': newStop #n
        '76': selectLast #l
        '70': selectFirst #f
      keypress:
        'up': selectPrev
        'down': selectNext
    editing: {
      keyup: {}
      keypress: {}
    }

  enterEdit = ->
    $scope.setKeymap states.editing

  exitEdit = ->
    $scope.setKeymap states.navigating

  $scope.keymap = states.navigating

  $scope.$watch 'stoplist.editing()', (editing) ->
    if editing
      enterEdit()
    else
      exitEdit()
]

