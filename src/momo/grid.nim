import vector
export vector

const falseChar = '-'
const trueChar = '#'

type
  Grid*[T] = ref object
    size: IVec2
    cells: seq[T]
  BGrid* = Grid[bool]
  IGrid* = Grid[int32]
  UGrid* = Grid[uint32]
  FGrid* = Grid[float32]
  DGrid* = Grid[float64]

# Helper Templates

template genCon[T](name: untyped) =
  ## Generates grid constructors for a specific type.
  func name*(width, height: int32, value: T): Grid[T] =
    result = Grid[T](size: ivec2(width, height))
    for i in 0 ..< width * height:
      result.cells.add(value)

  func name*(width, height: int32): Grid[T] =
    result = Grid[T](size: ivec2(width, height))
    for i in 0 ..< width * height:
      result.cells.add(T.default)

  func name*(size: IVec2, value: T): Grid[T] =
    result = Grid[T](size: size)
    for i in 0 ..< size.x * size.y:
      result.cells.add(value)

  func name*(size: IVec2): Grid[T] =
    result = Grid[T](size: size)
    for i in 0 ..< size.x * size.y:
      result.cells.add(T.default)

  func name*(): Grid[T] =
    Grid[T]()

# Constructors

func newGrid*[T](width, height: int32, value: T): Grid[T] =
  result = Grid[T](size: ivec2(width, height))
  for i in 0 ..< width * height:
    result.cells.add(value)

func newGrid*[T](width, height: int32): Grid[T] =
  result = Grid[T](size: ivec2(width, height))
  for i in 0 ..< width * height:
    result.cells.add(T.default)

func newGrid*[T](size: IVec2, value: T): Grid[T] =
  result = Grid[T](size: size)
  for i in 0 ..< size.x * size.y:
    result.cells.add(value)

func newGrid*[T](size: IVec2): Grid[T] =
  result = Grid[T](size: size)
  for i in 0 ..< size.x * size.y:
    result.cells.add(T.default)

func newGrid*[T](): Grid[T] =
  Grid[T]()

genCon[bool](newBGrid)
genCon[int32](newIGrid)
genCon[uint32](newUGrid)
genCon[float32](newFGrid)
genCon[float64](newDGrid)

# Functions

func width*[T](self: Grid[T]): int32 =
  ## Returns the width of the grid.
  self.size.x

func height*[T](self: Grid[T]): int32 =
  ## Returns the height of the grid.
  self.size.y

func size*[T](self: Grid[T]): IVec2 =
  ## Returns the size of the grid.
  self.size

func cells*[T](self: Grid[T]): seq[T] =
  ## Returns the cells of the grid.
  self.cells

func len*[T](self: Grid[T]): int32 =
  ## Returns the length of the grid.
  ## Length is the width multiplied by the height of the grid.
  self.size.x * self.size.y

func id*[T](self: Grid[T], p: IVec2): int32 =
  ## Returns the id of the point.
  ## Id is an actual index to the internal one-dimensional sequence.
  p.y * self.width + p.x

func point*[T](self: Grid[T], id: int32): IVec2 =
  ## Returns the point of the id.
  ivec2(id mod self.size.x, id div self.size.y)

func set*[T](self: Grid[T], p: IVec2, value: T) =
  ## Sets the value to the given point on the grid.
  self.cells[self.id(p)] = value

func get*[T](self: Grid[T], p: IVec2): T =
  ## Gets the value from the given point on the grid.
  self.cells[self.id(p)]

func swap*[T](self: Grid[T], p1, p2: IVec2) =
  ## Swaps the values of point p1 and point p2 on the grid.
  let temp = self.get(p1)
  self.set(p1, self.get(p2))
  self.set(p2, temp)

func fill*[T](self: Grid[T], value: T) =
  ## Fills the grid with one value.
  for i in 0 ..< self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], p1, p2: IVec2, value: T) =
  ## Fills a part of the grid with one value.
  ## The first point is p1 and the last point is p2.
  var x1, y1, x2, y2: int32
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
      self.set(ivec2(x, y), value)

func clear*[T](self: Grid[T]) =
  ## Fills the grid with the default value of the grid type.
  self.fill(T.default)

func clear*[T](self: Grid[T], p1, p2: IVec2) =
  ## Fills a part of the grid with the default value of the grid type.
  ## The first point is p1 and the last point is p2.
  self.fill(p1, p2, T.default)

func enclose*[T](self: Grid[T], value: T) =
  ## Encloses the grid with one value.
  for y in 0 ..< self.height:
    if y == 0 or y == self.height - 1:
      for x in 0 ..< self.width:
        self.set(ivec2(x, y), value)
    else:
      self.set(ivec2(0, y), value)
      self.set(ivec2(self.width - 1, y), value)

func enclose*[T](self: Grid[T], p1, p2: IVec2, value: T) =
  ## Encloses a part of the grid with one value.
  ## The first point is p1 and the last point is p2.
  var x1, y1, x2, y2: int32
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
        self.set(ivec2(x, y), value)
    else:
      self.set(ivec2(x1, y), value)
      self.set(ivec2(x2, y), value)

func isEmpty*[T](self: Grid[T], p: IVec2): bool =
  ## Returns true if the point has the default value of the grid type.
  self.get(p) == T.default

func isInside*[T](self: Grid[T], p: IVec2): bool =
  ## Returns true if the point is inside the grid.
  p.x >= 0 and p.x < self.size.x and p.y >= 0 and p.y < self.size.y

func `==`*[T](a, b: Grid[T]): bool =
  a.cells == b.cells

func `!=`*[T](a, b: Grid[T]): bool =
  a.cells != b.cells

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

iterator items*[T](self: Grid[T]): T =
  ## Returns the cells of the grid.
  for a in self.cells:
    yield a

iterator pairs*[T](self: Grid[T]): (IVec2, T) =
  ## Returns the points and the cells of the grid.
  for a, b in self.cells:
    yield (self.point(a.int32), b)
