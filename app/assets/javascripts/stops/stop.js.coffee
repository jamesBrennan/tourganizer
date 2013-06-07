Tourganizer.Stops.Stop = ['$resource', ($resource) ->
  stop = $resource('stops/:id')
  query: -> stop.query(arguments)
  get: -> stop.get(arguments)
]

angular.module('stops').service 'Stop', Tourganizer.Stops.Stop
