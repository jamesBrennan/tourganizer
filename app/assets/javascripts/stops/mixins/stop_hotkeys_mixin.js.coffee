Tourganizer.Stops.StopHotkeysMixin = ["$scope", ($scope) ->
  enterEdit = ->
    $scope.enterEdit($scope.stop)
    $scope.keymap = states.editing
    $scope.focus($scope.stop)

  exitEdit = ->
    $scope.exitEdit($scope.stop)
    $scope.keymap = states.navigating

  open = ->
    window.location = "/#/stops/edit/#{$scope.stop.id}"

  cancelEdit = ->
    exitEdit()
    $scope.stop.$get() if $scope.stop.id

  saveEdit = (scope, locals) ->
    locals.$event.preventDefault();
    $scope.save($scope.stop)

  deleteStop = (scope, locals) ->
    return if $scope.editing
    locals.$event.stopImmediatePropagation();
    $scope.destroy($scope.stop)

  states =
    navigating:
      keyup:
        '69': enterEdit #e
        '68': deleteStop #d
        '79': open #o
    editing:
      keyup:
        'esc': cancelEdit
        'ctrl-83': saveEdit #s

  $scope.keymap = states.navigating

  if $scope.stop.editing
    enterEdit()
]
