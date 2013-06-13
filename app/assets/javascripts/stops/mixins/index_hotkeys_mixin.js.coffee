Tourganizer.Stops.StopsHotkeysMixin = ["$scope", "ScheduleService", '$document', ($scope, ScheduleService, $document) ->

  #convenience methods
  listScope   = -> $('table.stops').scope()
  stoplist    = -> listScope().stoplist
  stops       = -> listScope().stoplist.stops
  targetScope = (locals) -> $(locals.$event.target).scope()
  current     = -> $(document.activeElement).scope().stop

  select = (scope, locals) ->
    s = targetScope(locals)
    stoplist().select(s.stop) if s.stop && s.stops

  selectAndFocus = (stop) ->
    stoplist().selectOnly stop
    listScope().focus(stop)
    stop

  selectFirst = ->
    selectAndFocus stoplist().first()

  selectLast = ->
    selectAndFocus stoplist().last()

  selectPrev = ->
    stop = stoplist().beforeSelection()
    if stop then selectAndFocus(stop) else selectLast()

  selectNext = ->
    stop = stoplist().afterSelection()
    if stop then selectAndFocus(stop) else selectFirst()

  mulitSelectPrev = ->
    list = stoplist()

    if list.selected().length == 1
      list.select_root = current()
      list.last_selected = current()

    stop = list.before current()

    if stop
      if stop.selected
        if list.closerToRoot(stop)
          list.deselect(list.last_selected)
        else
          list.deselect(stop)
      else
        list.select(stop)
      listScope().focus(stop)

  mulitSelectNext = ->
    list = stoplist()
    if list.selected().length == 1
      list.select_root = current()
      list.last_selected = current()

    stop = list.after current()

    if stop
      if stop.selected
        if list.closerToRoot(stop)
          list.deselect(list.last_selected)
        else
          list.deselect(stop)
      else
        list.select(stop)
      listScope().focus(stop)
      list.last_selected = stop

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
        'shift-up': mulitSelectPrev
        'shift-down': mulitSelectNext
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

