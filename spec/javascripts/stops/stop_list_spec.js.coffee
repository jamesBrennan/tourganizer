describe 'StopList', ->
  beforeEach module 'stops'

  describe 'editing', ->
    beforeEach ->
      @list = new Tourganizer.Stops.StopList({stops: [{editing: true} , {editing: false}] })

    it 'returns the first element who\'s .editing property returns true', ->
      expect(@list.editing()).toEqual(@list.stops[0])

    it 'returns undefined if no element is being edited', ->
      @list.stops[0].editing = false
      @list
      expect(@list.editing()).toBeUndefined()

    it 'has stops', ->
      @list.stops.length = 2

