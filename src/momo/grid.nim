type
  Point* = tuple
    x, y: uint
  Grid*[T] = ref object
    width: uint
    height: uint
    cells: seq[T]
  BGrid* = Grid[bool]
  IGrid* = Grid[int32]
  UGrid* = Grid[uint32]
  FGrid* = Grid[float32]
  DGrid* = Grid[float64]

func point*(x, y: uint): Point = (x, y)
func point*(value: uint): Point = (value, value)

func newGrid*[T](width, height: uint): Grid[T] =
  result = Grid[T](width: width, height: height)
  for i in 0 .. width * height:
    result.cells.add(T.default)

func newBGrid*(width, height: uint): BGrid = newGrid[bool](width, height)
func newIGrid*(width, height: uint): IGrid = newGrid[int32](width, height)
func newUGrid*(width, height: uint): UGrid = newGrid[uint32](width, height)
func newFGrid*(width, height: uint): FGrid = newGrid[float32](width, height)
func newDGrid*(width, height: uint): DGrid = newGrid[float64](width, height)

func width*(self: Grid): uint = self.width
func height*(self: Grid): uint = self.height
func cells*(self: Grid): uint = self.cells

func len*(self: Grid) = self.width * self.height

func id*(self: Grid, x, y: uint): uint = y * self.width + x
func id*(self: Grid, p: Point): uint = self.id(p.x, p.y)

func point*(self: Grid, id: uint): Point =
  (id mod self.width, id div self.width)

func set*[T](self: Grid[T], id: uint, value: T) = self.cells[id] = value
func set*[T](self: Grid[T], x, y: uint, value: T) = self.set(self.id(x, y), value)
func set*[T](self: Grid[T], p: Point, value: T) = self.set(p.x, p.y, value)

func get*[T](self: Grid[T], id: uint): T = self.cells[id]
func get*[T](self: Grid[T], x, y: uint): T = self.get(self.id(x, y))
func get*[T](self: Grid[T], p: Point): T = self.get(p.x, p.y)

func swap*(self: Grid, id1, id2: uint) =
  let temp = self.get(id1)
  self.set(id1, self.get(id2))
  self.set(id2, temp)

func swap*(self: Grid, x1, y1, x2, y2: uint) =
  self.swap(self.id(x1, y1), self.id(x2, y2))

func swap*(self: Grid, p1, p2: Point) =
  self.swap(p1.x, p1.y, p2.x, p2.y)

func fill*[T](self: Grid[T], value: T) =
  for i in 0 .. self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], id1, id2: uint, value: T) =
  let ida, idb: uint
  if id1 > id2:
    ida = id1
    idb = id2
  else:
    ida = id2
    idb = id1
  for i in ida .. idb:
    self.set(i, value)

func fill*[T](self: Grid[T], x1, y1, x2, y2: uint, value: T) =
  let xa, ya, xb, yb: uint
  if x1 > x2:
    xa = x1
    xb = x2
  else:
    xa = x2
    xb = x1
  if y1 > y2:
    ya = y1
    yb = y2
  else:
    ya = y2
    yb = y1

  for y in ya .. yb:
    for x in xa .. xb:
      self.set(x, y, value)

func fill*[T](self: Grid[T], p1, p2: Point) =
  self.fill(p1.x, p1.y, p2.x, p2.y)

func clear*[T](self: Grid[T]) =
  self.fill(T.default)

func clear*[T](self: Grid[T], x1, y1, x2, y2: uint) =
  self.fill(x1, y1, x2, y2, T.default)

func clear*[T](self: Grid[T], p1, p2: Point) =
  self.fill(p1, p2, T.default)

func isEmpty*[T](self: Grid[T], id: uint): bool = self.get(id) == T.default
func isEmpty*[T](self: Grid[T], x, y: uint): bool = self.isEmpty(self.id(x, y))
func isEmpty*[T](self: Grid[T], p: Point): bool = self.isEmpty(p.x, p.y)

func isInside*[T](self: Grid[T], id: uint): bool = id < self.len
func isInside*[T](self: Grid[T], x, y: uint): bool = x * y < self.len
func isInside*[T](self: Grid[T], p: Point): bool = self.isInside(p.x, p.y)

func `$`*[T](self: Grid[T]): string =
  result = ""
  for y in 0 ..< self.height:
    for x in 0 ..< self.width:
      result.add($self.get(x, y))
      if x != self.width - 1:
        result.add(' ')
    if y != self.height - 1:
      result.add('\n')

iterator items*[T](self: Grid[T]): T =
  for a in self.cells:
    yield a

iterator pairs*[T](self: Grid[T]): tuple[a: uint, b: T] =
  for a, b in self.cells:
    yield (a, b)

iterator row*[T](self: Grid[T], n: uint): T =
  var i = 0
  while i < self.width:
    yield self.get(i, n)
    i += 1

iterator column*[T](self: Grid[T], n: uint): T =
  var i = 0
  while i < self.height:
    yield self.get(n, i)
    i += 1
