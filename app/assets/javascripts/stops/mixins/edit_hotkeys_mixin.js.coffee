Tourganizer.Stops.EditHotkeysMixin = ["$scope", ($scope) ->

  newVenue = ->
    console.log 'new venue'
    $scope.addVenue()

  $scope.keymap =
    keyup:
      'alt-78': newVenue #n
]
