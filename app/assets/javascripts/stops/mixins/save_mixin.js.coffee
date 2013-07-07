Tourganizer.Stops.SaveMixin = ['$scope', '$q', ($scope, $q) ->
  $scope.save = (stop) ->
    method = if stop.id then '$update' else '$save'
    deferred = $q.defer()
    stop[method] ->
      deferred.resolve(stop)
      $scope.$emit 'notify', type: 'info', message: 'Stop saved'
      $scope.$broadcast "stop#{stop.$$hashKey}-saved", stop
    , (error) ->
      deferred.reject(error)
      $scope.$emit 'notify', type: 'error', message: 'error saving'

    deferred.promise
]
