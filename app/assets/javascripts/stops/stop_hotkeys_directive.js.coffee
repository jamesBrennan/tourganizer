#= require stops/mixins/stop_hotkeys_mixin
#= require_self

Tourganizer.Stops.StopHotkeysDirective = ['keypressHelper', '$injector', (keypressHelper, $injector) ->
  priority: 100
  link: (scope, el, attrs) ->
    $injector.invoke(Tourganizer.Stops.StopHotkeysMixin, @, $scope: scope)
    scope.$watch 'keymap', ->
      keypressHelper(scope, el, attrs)
]

angular.module('stops').directive 'tStopHotkeys', Tourganizer.Stops.StopHotkeysDirective
