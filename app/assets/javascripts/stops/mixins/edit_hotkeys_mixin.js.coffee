Tourganizer.Stops.EditHotkeysMixin = ["$scope", ($scope) ->

  targetScope = (locals) -> $(locals.$event.target).scope()

  _isVenueChild = (el) ->
    $(el).hasClass('venue') || $(el).parents("li.venue").length > 0

  newInfo = (scope, locals) ->
    if _isVenueChild locals.$event.target
      newProperty(scope, locals)
    else
      newVenue()

  newVenue = ->
    $scope.addVenue()

  newProperty = (scope, locals) ->
    el = locals.$event.target
    name = if $(el).data('name') then $(el).data('name') else $(el).parent("li.venue").data('name')
    targetScope(locals).addProperty(name)

  save = (scope) ->
    scope = if scope.stop? then scope else $('.stop').scope()
    stop = scope.stop
    scope.save(stop)

  $scope.keymap =
    keyup:
      'alt-78': newInfo #n
      'alt-80': newProperty #p
      'alt-83': save #s
]
