angular.module('stops', [])

Tourganizer.StopsController = ($scope) ->
  $scope.stops = [
    date: new Date(),
    location: "Washington, DC",
    venues: [
      name: "The Black Cat", capacity: 250
      name: "Velvet Lounge", capacity: 100
    ]
  ]

Tourganizer.StopsController.$inject = ["$scope"]
angular.module('stops').controller 'StopsController', Tourganizer.StopsController

Tourganizer.StopsDirective = () ->
  controller: Tourganizer.StopsController
  link: (scope, el, attrs, controller) ->

angular.module('stops').directive 'tStops', Tourganizer.StopsDirective
