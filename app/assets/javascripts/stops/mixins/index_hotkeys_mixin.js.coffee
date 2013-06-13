Tourganizer.Stops.StopsHotkeysMixin = ["$scope", "ScheduleService", '$document', ($scope, ScheduleService, $document) ->

  #convenience methods
  listScope   = -> $('table.stops').scope()
  stoplist    = -> listScope().stoplist
  stops       = -> listScope().stoplist.stops
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

  shiftDates = ->
    days = window.prompt('How many days?')
    ScheduleService.nudgeDays stoplist(), days

  states =
    navigating:
      keyup:
        'tab': select
        'shift-tab': select
        '78': newStop #n
        '76': selectLast #l
        '70': selectFirst #f
        'shift-68': shiftDates #d
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

