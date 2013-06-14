describe 'MultiSelect', ->

  beforeEach ->
    @MultiSelect = Tourganizer.Util.MultiSelect
    @stoplist = Factory.build('stoplist')
    @root = @stoplist.stops[2]
    @multi = new @MultiSelect(@root, @stoplist.stops)

  describe 'constructor', ->
    it 'assigns root and list', ->
      expect(@multi.root).toEqual(@root)
      expect(@multi.list).toEqual(@stoplist.stops)

    it 'throws an error if root is not a member of list', ->
      expect( => new @MultiSelect({}, @stoplist.stops)).toThrow new Error('MultiSelect: root must be a member of list.')

    it 'sets the cursor to the position of root', ->
      expect(@multi.cursor).toEqual @stoplist.stops.indexOf(@root)

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
      expect( => @multi.include({})).toThrow new Error("MultiSelect: included element must be member of list.")

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



