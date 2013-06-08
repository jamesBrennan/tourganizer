Tourganizer.Stops.Stop = ['$resource', ($resource) ->
  $resource 'stops/:id', {id:'@id'}, {
    'update': { method: 'PUT' }
  }
]

angular.module('stops').factory 'Stop', Tourganizer.Stops.Stop
