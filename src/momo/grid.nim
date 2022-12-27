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
  self.size.x

func height*[T](self: Grid[T]): int32 =
  self.size.y

func size*[T](self: Grid[T]): IVec2 =
  self.size

func cells*[T](self: Grid[T]): seq[T] =
  self.cells

func len*[T](self: Grid[T]): int32 =
  self.size.x * self.size.y

func id*[T](self: Grid[T], p: IVec2): int32 =
  p.y * self.width + p.x

func point*[T](self: Grid[T], id: int32): IVec2 =
  ivec2(id mod self.size.x, id div self.size.y)

func set*[T](self: Grid[T], p: IVec2, value: T) =
  self.cells[self.id(p)] = value

func get*[T](self: Grid[T], p: IVec2): T =
  self.cells[self.id(p)]

func swap*[T](self: Grid[T], p1, p2: IVec2) =
  let temp = self.get(p1)
  self.set(p1, self.get(p2))
  self.set(p2, temp)

func fill*[T](self: Grid[T], value: T) =
  for i in 0 ..< self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], p1, p2: IVec2, value: T) =
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
  self.fill(T.default)

func clear*[T](self: Grid[T], p1, p2: IVec2) =
  self.fill(p1, p2, T.default)

func enclose*[T](self: Grid[T], value: T) =
  for y in 0 ..< self.height:
    if y == 0 or y == self.height - 1:
      for x in 0 ..< self.width:
        self.set(ivec2(x, y), value)
    else:
      self.set(ivec2(0, y), value)
      self.set(ivec2(self.width - 1, y), value)

func enclose*[T](self: Grid[T], p1, p2: IVec2, value: T) =
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
  self.get(p) == T.default

func isInside*[T](self: Grid[T], p: IVec2): bool =
  p.x >= 0 and p.x < self.width and p.y >= 0 and p.y < self.height

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
  for a in self.cells:
    yield a

iterator pairs*[T](self: Grid[T]): (int, T) =
  for a, b in self.cells:
    yield (a, b)
