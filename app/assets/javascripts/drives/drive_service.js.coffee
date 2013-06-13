Tourganizer.Drives.DriveService = (Drive, Stop, DistanceMatrixService, $q) ->
  @drives = {}

  matrix_params = (from, to) ->
    origins: [from],
    destinations: [to],
    travelMode: google.maps.TravelMode.DRIVING,
    avoidHighways: false,
    avoidTolls: false,
    unitSystem: google.maps.UnitSystem.IMPERIAL

  find_or_create: (args) ->
    {from, to} = args
    deferred = $q.defer()
    Drive.query {origin_id: from.id, destination_id: to.id}, (drives) ->
      if drives.length
        deferred.resolve(drives)
      else
        DistanceMatrixService.getDistanceMatrix matrix_params(from.location, to.location),
            (response) ->
              new Drive(
                origin_id: from.id,
                destination_id: to.id,
                distance_matrix: response.rows[0].elements[0]
              ).
              $save (drive) ->
                deferred.resolve(drive)

    deferred.promise


Tourganizer.Drives.DriveService.$inject = ['Drive', 'Stop', 'DistanceMatrixService', '$q']
angular.module('drives').service 'DriveService', Tourganizer.Drives.DriveService
