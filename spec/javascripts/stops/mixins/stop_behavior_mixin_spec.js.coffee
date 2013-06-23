describe 'StopBehaviorMixin', ->
  beforeEach inject ($injector) ->
    @stop = {}
    $injector.invoke(Tourganizer.Stops.StopBehaviorMixin, @, stop: @stop)

  describe 'select', ->
    it 'sets the selected property to true', ->
      @stop.select()
      expect(@stop.selected).toBe true

  describe 'deselect', ->
    it 'sets the selected property to false', ->
      @stop.deselect()
      expect(@stop.selected).toBe false

  describe 'toggleSelection', ->
    it 'toggles the selected state', ->
      @stop.select()
      @stop.toggleSelection()
      expect(@stop.selected).toBe false
      @stop.toggleSelection()
      expect(@stop.selected).toBe true

  describe 'mark', ->
    it 'sets the marked property to true', ->
      @stop.mark()
      expect(@stop.marked).toBe true

  describe 'unmark', ->
    it 'sets the marked property to be false', ->
      @stop.unmark()
      expect(@stop.marked).toBe false

  describe 'toggleMarked', ->
    it 'toggles the marked property', ->
      @stop.mark()
      @stop.toggleMarked()
      expect(@stop.marked).toBe false
      @stop.toggleMarked()
      expect(@stop.marked).toBe true

  describe 'edit', ->
    beforeEach ->
      @stop.edit()

    it 'sets the editing property to true', ->
      expect(@stop.editing).toBe true

    it 'sets the dirty property to true', ->
      expect(@stop.dirty).toBe true

  describe 'cancelEdit', ->
    it 'sets the editing property to false', ->
      @stop.cancelEdit()
      expect(@stop.editing).toBe false

    it 'reverts the state', ->
      @stop.foo = 'foo'
      @stop.edit()
      @stop.foo = 'baz'
      @stop.cancelEdit()
      expect(@stop.foo).toEqual 'foo'

  describe 'toggleEdit', ->
    it 'toggles the editing property', ->
      @stop.edit()
      @stop.toggleEdit()
      expect(@stop.editing).toBe false
