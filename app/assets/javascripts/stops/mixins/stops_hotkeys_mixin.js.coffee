Tourganizer.Stops.StopsHotkeysMixin = ($scope, ScheduleService) ->

  functions =
    newStop: ->

    shiftDates: ->
      days = window.prompt('How many days?')
      ScheduleService.nudgeDays stoplist(), days

  states =
    navigating:
      keypress: {}
      keyup:
        '78': functions.newStop #n
        'shift-68': functions.shiftDates #d
    editing: {
      keyup: {}
      keypress: {}
    }

  enterEdit = ->
    $scope.setKeymap states.editing

  exitEdit = ->
    $scope.setKeymap states.navigating

  $scope.select_list_functions = functions
  $scope.keymap = states.navigating

  $scope.$watch 'stoplist.editing()', (editing) ->
    if editing
      enterEdit()
    else
      exitEdit()

Tourganizer.Stops.StopsHotkeysMixin.$inject = ["$scope", "ScheduleService"]
