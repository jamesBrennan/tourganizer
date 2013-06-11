Tourganizer.Drives.DriveService = (Drive, Stop, DistanceMatrixService) ->
  @drives = {}

  create: (origin, destination) ->
    drive = new Drive(origin_id: origin.id, destination_id: destination.id)
    drive.$save(->
      unless drive.distance_matrix
        DistanceMatrixService.getDistanceMatrix(
          origins: [drive.origin.location],
          destinations: [drive.destination.location],
          travelMode: google.maps.TravelMode.DRIVING,
          avoidHighways: false,
          avoidTolls: false,
          unitSystem: google.maps.UnitSystem.IMPERIAL
        , (response) ->
          drive.distance_matrix = response.rows[0].elements[0]
          drive.$update()
        )
    )

Tourganizer.Drives.$inject = ['Drive']
angular.module('drives').service 'DriveService', Tourganizer.Drives.DriveService
