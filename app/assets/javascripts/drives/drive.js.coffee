Tourganizer.Drives.Drive = ['$resource', ($resource) ->
  $resource 'drives/:id', {id:'@id'}, {
    'update': { method: 'PUT' }
  }
]

angular.module('drives').factory 'Drive', Tourganizer.Drives.Drive
