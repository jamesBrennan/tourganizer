describe 'MultiSelectHotkeysMixin', ->
  beforeEach module 'stops'

  beforeEach inject ($rootScope, $injector) ->
    @scope = $rootScope.$new()
    @stoplist = Factory.build('stoplist')
    @stoplist.stops.splice(3,4) #truncate stoplist. We don't need 7 elements.
    @multi = new Tourganizer.Util.MultiSelect(@stoplist.stops)
    expect(@multi.cursor?).toBe false
    $injector.invoke(Tourganizer.Stops.MultiSelectHotkeysMixin, @, $scope: @scope, multiselect: @multi)
    @fns = @scope.multiselect_functions

  describe 'invocation', ->
    it 'adds the hotkey functions to the scope', ->
      expect(_.keys @fns).toEqual(
        ['selectPrev', 'selectNext', 'multiSelectPrev', 'multiSelectNext']
      )

  describe 'selectPrev', ->
    it 'selects the last element if no element is selected', ->
      @fns.selectPrev()
      expect(@multi.selected).toEqual [undefined, undefined, @stoplist.stops[2]]

    it 'selects the previous adjacent element', ->
      @fns.selectPrev()
      @fns.selectPrev()
      expect(@multi.selected).toEqual [undefined, @stoplist.stops[1]]

    it 'selects the last element if the current element is the first', ->
      @fns.selectNext()
      @fns.selectPrev()
      expect(@multi.selected).toEqual [undefined, undefined, @stoplist.stops[2]]


  describe 'selectNext', ->
    it 'selects the first element if no element is selected', ->
      @fns.selectNext()
      expect(@multi.selected).toEqual [@stoplist.stops[0]]

    it 'selects the next adjacent element', ->
      @fns.selectNext()
      @fns.selectNext()
      expect(@multi.selected).toEqual [undefined, @stoplist.stops[1]]

    it 'selects the first element if the current element is last', ->
      @fns.selectPrev()
      @fns.selectNext()
      expect(@multi.selected).toEqual [@stoplist.stops[0]]

  describe 'multiSelectPrev', ->
    it 'expands the selection to include the prev adjacent element', ->
      @fns.selectPrev()
      @fns.multiSelectPrev()
      expect(@multi.selected).toEqual [undefined, @stoplist.stops[1], @stoplist.stops[2]]

    it 'does not wrap around to the top of the list', ->
      @fns.selectNext()
      @fns.multiSelectPrev()
      expect(@multi.selected).toEqual [@stoplist.stops[0]]

  describe 'multiSelectNext', ->
    it 'expands the selection to include the next adjacent element', ->
      @fns.selectNext()
      @fns.multiSelectNext()
      expect(@multi.selected).toEqual [@stoplist.stops[0], @stoplist.stops[1]]

    it 'does not wrap around to the bottom of the list', ->
      @fns.selectPrev()
      @fns.multiSelectNext()
      expect(@multi.selected).toEqual [undefined, undefined, @stoplist.stops[2]]
