Tourganizer.Stops.Stop = ['$resource', ($resource) ->
  $resource 'stops/:id', {id:'@id'}
]

angular.module('stops').factory 'Stop', Tourganizer.Stops.Stop
