describe 'StopsHotkeysMixin', ->
  beforeEach module 'tourganizer'

  beforeEach inject ($rootScope, $injector, @$window) ->
    @scope = $rootScope.$new()
    @listScope = @scope.$new()
    @targetScope = @listScope.$new()
    @targetScope.stop = Factory.build('stop')

    $injector.invoke(Tourganizer.Stops.StopsHotkeysMixin, @, $scope: @scope)
    spyOn(@scope, 'listScope').andReturn(@listScope)

  it 'adds a keymap to the scope', ->
    expect(@scope.keymap).not.toBeUndefined()

  it 'calls select on tab', ->
    Tourganizer.keypress(@$window.document, 'tab')
