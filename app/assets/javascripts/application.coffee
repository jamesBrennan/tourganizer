#= require vendor
#= require_self
#= require stops
#= require_tree .

window.Tourganizer =
  Config: {}

modules = ''.split(' ')

application = angular.module('tourganizer', modules)

application.config ["$httpProvider", "$provide", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common['Authorization'] = "Token token=" + $('meta[name=wonderful-api-key]').attr('content')
]
