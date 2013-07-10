Booking = ['$resource', ($resource) ->
  $resource 'app/:stop_id/bookings/:id', {stop_id: '@stop.id', id:'@id'}, {
    'update': { method: 'PUT' }
  }
]

angular.module('bookings').factory 'Booking', Booking
