import vector

const falseChar = '-'
const trueChar = '#'

type
  GridPoint* = GVec2[int]
  Grid*[T] = ref object
    width: int
    height: int
    cells: seq[T]
  BGrid* = Grid[bool]
  IGrid* = Grid[int32]
  UGrid* = Grid[uint32]
  FGrid* = Grid[float32]
  DGrid* = Grid[float64]

# Constructors for GridPoint

func gridPoint*(x, y: int): GridPoint = gvec2[int](x, y)
func gridPoint*(x: int): GridPoint = gvec2[int](x)
func gridPoint*(): GridPoint = gvec2[int](0)

# Constructors for Grid

func newGrid*[T](width, height: int, value: T): Grid[T] =
  result = Grid[T](width: width, height: height)
  for i in 0 ..< width * height:
    result.cells.add(value)

func newGrid*[T](width, height: int): Grid[T] =
  newGrid[T](width, height, T.default)

func newBGrid*(width, height: int, value: bool): BGrid =
  newGrid[bool](width, height, value)

func newIGrid*(width, height: int, value: int32): IGrid =
  newGrid[int32](width, height, value)

func newUGrid*(width, height: int, value: uint32): UGrid =
  newGrid[uint32](width, height, value)

func newFGrid*(width, height: int, value: float32): FGrid =
  newGrid[float32](width, height, value)

func newDGrid*(width, height: int, value: float64): DGrid =
  newGrid[float64](width, height, value)

func newBGrid*(width, height: int): BGrid =
  newGrid[bool](width, height)

func newIGrid*(width, height: int): IGrid =
  newGrid[int32](width, height)

func newUGrid*(width, height: int): UGrid =
  newGrid[uint32](width, height)

func newFGrid*(width, height: int): FGrid =
  newGrid[float32](width, height)

func newDGrid*(width, height: int): DGrid =
  newGrid[float64](width, height)

# Functions for Grid

func width*[T](self: Grid[T]): int =
  self.width

func height*[T](self: Grid[T]): int =
  self.height

func cells*[T](self: Grid[T]): seq[T] =
  self.cells

func len*[T](self: Grid[T]): int =
  self.cells.len

func id*[T](self: Grid[T], p: GridPoint): int =
  p.y * self.width + p.x

func point*[T](self: Grid[T], id: int): GridPoint =
  gridPoint(id mod self.width, id div self.width)

func set*[T](self: Grid[T], p: GridPoint, value: T) =
  self.cells[self.id(p)] = value

func get*[T](self: Grid[T], p: GridPoint): T =
  self.cells[self.id(p)]

func swap*[T](self: Grid[T], p1, p2: GridPoint) =
  let temp = self.get(p1)
  self.set(p1, self.get(p2))
  self.set(p2, temp)

func fill*[T](self: Grid[T], value: T) =
  for i in 0 ..< self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], p1, p2: GridPoint, value: T) =
  var x1, y1, x2, y2: int
  if p1.x < p2.x:
    x1 = p1.x
    x2 = p2.x
  else:
    x1 = p2.x
    x2 = p1.x
  if p1.y < p2.y:
    y1 = p1.y
    y2 = p2.y
  else:
    y1 = p2.y
    y2 = p1.y
  for y in y1 .. y2:
    for x in x1 .. x2:
      self.set(gridPoint(x, y), value)

func clear*[T](self: Grid[T]) =
  self.fill(T.default)

func clear*[T](self: Grid[T], p1, p2: GridPoint) =
  self.fill(p1, p2, T.default)

func enclose*[T](self: Grid[T], value: T) =
  for y in 0 ..< self.height:
    if y == 0 or y == self.height - 1:
      for x in 0 ..< self.width:
        self.set(gridPoint(x, y), value)
    else:
      self.set(gridPoint(0, y), value)
      self.set(gridPoint(self.width - 1, y), value)

func enclose*[T](self: Grid[T], p1, p2: GridPoint, value: T) =
  var x1, y1, x2, y2: int
  if p1.x < p2.x:
    x1 = p1.x
    x2 = p2.x
  else:
    x1 = p2.x
    x2 = p1.x
  if p1.y < p2.y:
    y1 = p1.y
    y2 = p2.y
  else:
    y1 = p2.y
    y2 = p1.y
  for y in y1 .. y2:
    if y == y1 or y == y2:
      for x in x1 .. x2:
        self.set(gridPoint(x, y), value)
    else:
      self.set(gridPoint(x1, y), value)
      self.set(gridPoint(x2, y), value)

func isEmpty*[T](self: Grid[T], p: GridPoint): bool =
  self.get(p) == T.default

func isInside*[T](self: Grid[T], p: GridPoint): bool =
  p.x >= 0 and p.x < self.width and p.y >= 0 and p.y < self.height

func `$`*[T](self: Grid[T]): string =
  result = ""
  for i, cell in self.cells:
    if i != 0 and i mod self.width == 0:
      result.add('\n')
    when T is bool:
      result.add(if cell: trueChar else: falseChar)
    else:
      result.add($cell)
    if i mod self.width != self.width - 1:
      result.add(' ')

func `==`*[T](a, b: Grid[T]): bool =
  a.cells == b.cells

func `!=`*[T](a, b: Grid[T]): bool =
  not (a == b)

iterator items*[T](self: Grid[T]): T =
  for a in self.cells:
    yield a

iterator pairs*[T](self: Grid[T]): (int, T) =
  for a, b in self.cells:
    yield (a, b)
