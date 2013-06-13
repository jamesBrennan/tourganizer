describe 'StopList', ->
  beforeEach module 'stops'

  beforeEach ->
    @list = new Tourganizer.Stops.StopList(stops: {},{})

  describe 'editing', ->
    beforeEach ->
      @list = new Tourganizer.Stops.StopList {stops: [{editing: true} , {editing: false}] }

    it 'returns the first element who\'s .editing property returns true', ->
      expect(@list.editing()).toEqual(@list[0])

    it 'returns undefined if no element is being edited', ->
      @list.stops[0].editing = false
      expect(@list.editing()).toBeUndefined()

    it 'has stops', ->
      @list.stops.length = 2

  describe 'closerToRoot', ->
    beforeEach ->
      @stop1 = {selected: true}
      @stop2 = {selected: true}
      @stop3 = {selected: true}
      scope = {stops: [@stop1, @stop2, @stop3]}
      @list = new Tourganizer.Stops.StopList(scope)

    it 'returns false for a stop with an index further away from the root node than the prev selection', ->
      @list.select_root = @stop1
      @list.last_selected = @stop2
      expect(@list.closerToRoot(@stop3)).toBe(false)

    it 'returns true for a stop with and index closer to the root node than the previous selection', ->
      @list.select_root = @stop1
      @list.last_selected = @stop3
      expect(@list.closerToRoot(@stop2)).toBe(true)
