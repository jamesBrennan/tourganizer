angular.module('maps', [])

angular.module('maps').value 'google_api_key', 'AIzaSyCUI4BouW-PIemmNqKmlPGyVbAjbBBfBpY'
angular.module('maps').service 'DistanceMatrixService', google.maps.DistanceMatrixService
