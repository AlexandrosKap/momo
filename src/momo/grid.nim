import vector

const falseChar = '-'
const trueChar = '#'

type
  GridVec* = GVec2[int]
  Grid*[T] = ref object
    size: GridVec
    cells: seq[T]
  BGrid* = Grid[bool]
  IGrid* = Grid[int32]
  UGrid* = Grid[uint32]
  FGrid* = Grid[float32]
  DGrid* = Grid[float64]

# Constructors for GridVec

func gridVec*(x, y: int): GridVec =
  GVec2[int](
    x: x,
    y: y
  )

func gridVec*(x: int): GridVec =
  GVec2[int](
    x: x,
    y: x
  )

func gridVec*(): GridVec =
  GVec2[int](
    x: 0,
    y: 0
  )

# Constructors for Grid

func newGrid*[T](size: GridVec, value: T): Grid[T] =
  result = Grid[T](size: size)
  for i in 0 ..< size.x * size.y:
    result.cells.add(value)

func newGrid*[T](size: GridVec): Grid[T] =
  newGrid[T](size, T.default)

func newBGrid*(size: GridVec, value: bool): BGrid =
  newGrid[bool](size, value)

func newIGrid*(size: GridVec, value: int32): IGrid =
  newGrid[int32](size, value)

func newUGrid*(size: GridVec, value: uint32): UGrid =
  newGrid[uint32](size, value)

func newFGrid*(size: GridVec, value: float32): FGrid =
  newGrid[float32](size, value)

func newDGrid*(size: GridVec, value: float64): DGrid =
  newGrid[float64](size, value)

func newBGrid*(size: GridVec): BGrid =
  newGrid[bool](size)

func newIGrid*(size: GridVec): IGrid =
  newGrid[int32](size)

func newUGrid*(size: GridVec): UGrid =
  newGrid[uint32](size)

func newFGrid*(size: GridVec): FGrid =
  newGrid[float32](size)

func newDGrid*(size: GridVec): DGrid =
  newGrid[float64](size)

# Functions for Grid

func width*[T](self: Grid[T]): int =
  self.size.x

func height*[T](self: Grid[T]): int =
  self.size.y

func size*[T](self: Grid[T]): GridVec =
  self.size

func cells*[T](self: Grid[T]): seq[T] =
  self.cells

func len*[T](self: Grid[T]): int =
  self.cells.len

func id*[T](self: Grid[T], p: GridVec): int =
  p.y * self.width + p.x

func point*[T](self: Grid[T], id: int): GridVec =
  gridVec(id mod self.size.x, id div self.size.y)

func set*[T](self: Grid[T], p: GridVec, value: T) =
  self.cells[self.id(p)] = value

func get*[T](self: Grid[T], p: GridVec): T =
  self.cells[self.id(p)]

func swap*[T](self: Grid[T], p1, p2: GridVec) =
  let temp = self.get(p1)
  self.set(p1, self.get(p2))
  self.set(p2, temp)

func fill*[T](self: Grid[T], value: T) =
  for i in 0 ..< self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], p1, p2: GridVec, value: T) =
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
      self.set(gridVec(x, y), value)

func clear*[T](self: Grid[T]) =
  self.fill(T.default)

func clear*[T](self: Grid[T], p1, p2: GridVec) =
  self.fill(p1, p2, T.default)

func enclose*[T](self: Grid[T], value: T) =
  for y in 0 ..< self.height:
    if y == 0 or y == self.height - 1:
      for x in 0 ..< self.width:
        self.set(gridVec(x, y), value)
    else:
      self.set(gridVec(0, y), value)
      self.set(gridVec(self.width - 1, y), value)

func enclose*[T](self: Grid[T], p1, p2: GridVec, value: T) =
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
        self.set(gridVec(x, y), value)
    else:
      self.set(gridVec(x1, y), value)
      self.set(gridVec(x2, y), value)

func isEmpty*[T](self: Grid[T], p: GridVec): bool =
  self.get(p) == T.default

func isInside*[T](self: Grid[T], p: GridVec): bool =
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
