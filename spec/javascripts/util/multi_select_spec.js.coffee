describe 'MultiSelect', ->

  beforeEach ->
    @MultiSelect = Tourganizer.Util.MultiSelect
    @stoplist = Factory.build('stoplist')
    @root = @stoplist.stops[2]
    @multi = new @MultiSelect(@stoplist.stops, @root)

  describe 'constructor', ->
    it 'assigns root and list', ->
      expect(@multi.root).toEqual(@root)
      expect(@multi.list).toEqual(@stoplist.stops)

    it 'throws an error if root is not a member of list', ->
      expect( => new @MultiSelect(@stoplist.stops, {})).toThrow new Error('MultiSelect: Element must be a member of list.')

    it 'sets the cursor to the position of root', ->
      expect(@multi.cursor).toEqual @stoplist.stops.indexOf(@root)

    it 'accepts a list with no root', ->
      multi = new @MultiSelect(@stoplist.stops)
      expect(multi.list).toEqual(@stoplist.stops)
      expect(multi.root).toBeUndefined()
      expect(multi.cursor).toBeUndefined()

  describe 'include', ->
    beforeEach ->
      @stop = @stoplist.stops[3]
      @selected = @multi.include(@stop)

    it 'sets the selected property of the passed element to true', ->
      expect(@stop.selected).toBe true

    it 'adds the passed element to .selected', ->
      expect(@multi.selected.indexOf(@stop)).toBeGreaterThan 0

    it 'adds the element to the same index in .selected as it has in .list', ->
      expect(@multi.selected.indexOf(@stop)).toEqual @stoplist.stops.indexOf(@stop)

    it 'returns an array with the currently selected elments', ->
      expect(@selected).toEqual [undefined, undefined, @root, @stop]

    it 'sets the cursor to the position of the new element', ->
      expect(@multi.cursor).toEqual @selected.indexOf(@stop)

    it 'throws an error if passed element is not a member of list', ->
      expect( => @multi.include({})).toThrow new Error("MultiSelect: Element must be a member of list.")

    it 'returns false if passed an element that is not adjacent to the upper index of .selected', ->
      expect(@multi.include(@stoplist.stops[5])).toBe false

    it 'returns false if passed an element that is not adjacent to the lower index of .selected', ->
      expect(@multi.include(@stoplist.stops[0])).toBe false

    it 'accepts an adjacent element with an index less than the root', ->
      stop = @stoplist.stops[1]
      expect(@multi.include(stop)).toEqual [undefined, stop, @root, @stop]

  describe 'exclude', ->
    beforeEach ->
      @stop3 = @stoplist.stops[3]
      @stop4 = @stoplist.stops[4]
      @multi.include(@stop3)
      @multi.include(@stop4)
      @selected = @multi.exclude(@stop4)

    it 'sets the selected property of the passed element to false', ->
      expect(@stop4.selected).toBe false

    it 'removes the passed element from selected', ->
      expect(@multi.selected.indexOf(@stop4)).toEqual -1

    it 'returns an array with the currently selected elements', ->
      expect(@selected).toEqual [undefined, undefined, @root, @stop3]

    it 'sets the cursor to the next adjacent selected element', ->
      expect(@multi.cursor).toEqual @selected.indexOf(@stop3)

    it 'returns false if passed an element this is not on the outer bounds of selected', ->
      @multi.include(@stop4)
      expect(@multi.exclude(@stop3)).toBe false

  describe 'reset', ->
    beforeEach ->
      @stop4 = @stoplist.stops[4]
      @multi.reset(@stop4)

    it 'sets the root to the given element', ->
      expect(@multi.root).toEqual @stop4

    it 'sets root to the only member of .selected', ->
      expect(@multi.selected).toEqual [undefined, undefined, undefined, undefined, @stop4]

    it 'sets the selected property of the given element to true', ->
      expect(@stop4.selected).toBe true

    it 'sets the selected property of all other elements to false', ->
      expect(@root.selected).toBe false

  describe 'moveCursorTo', ->

    it 'selects element under cursor if it is not selected', ->
      stop = @stoplist.stops[3]
      @multi.moveCursorTo(3)
      expect(stop.selected).toBe true

    it 'deselects the elements outside of the selected bounds', ->
      stop4 = @stoplist.stops[4]
      @multi.moveCursorTo(3)
      @multi.moveCursorTo(4)
      @multi.moveCursorTo(3)
      expect(stop4.selected).toBe false

    it 'returns selected if asked to move cursor outside of list bounds', ->
      @multi.reset(@stoplist.stops[0])
      expect(@multi.moveCursorTo(@multi.cursor - 1)).toEqual [@stoplist.stops[0]]
      @multi.reset(_.last @stoplist.stops)
      expect(@multi.moveCursorTo(@stoplist.stops.length)).toEqual [undefined, undefined, undefined, undefined, undefined, undefined, @stoplist.stops[6]]

    it 'works desceding and then ascending', ->
      @multi.reset(@stoplist.stops[5])
      @multi.moveCursorTo(4)
      @multi.moveCursorTo(3)
      @multi.moveCursorTo(2)
      @multi.moveCursorTo(1)
      @multi.moveCursorTo(2)
      @multi.moveCursorTo(3)
      expect(@multi.selected).toEqual [undefined, undefined, undefined, @stoplist.stops[3], @stoplist.stops[4], @stoplist.stops[5]]

