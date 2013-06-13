describe 'StopList', ->
  beforeEach module 'stops'

  beforeEach ->
    @list = new Tourganizer.Stops.StopList({},{})

  describe 'editing', ->
    beforeEach ->
      @list = new Tourganizer.Stops.StopList({editing: true},{})

    it 'returns the first element who\'s .editing property returns true', ->
      expect(@list.editing()).toEqual(@list[0])

    it 'returns undefined if no element is being edited', ->
      @list.stops[0].editing = false
      expect(@list.editing()).toBeUndefined()

    it 'has stops', ->
      @list.stops.length = 2

