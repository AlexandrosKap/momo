import unittest
import momo/grid

const size = gridVec(4, 4)
const first = gridVec()
const last = gridVec(size.x - 1, size.y - 1)

test "Grid":
  check gridVec(0, 0) == GridVec(x: 0, y: 0)
  check gridVec(0) == gridVec(0, 0)
  check gridVec() == gridVec(0)

  var g = newBGrid(size)
  check g.width == size.x
  check g.height == size.y
  check g.cells == newSeq[bool](size.x * size.y)
  check g.len == size.x * size.y
  check g.id(first) == 0
  check g.point(0) == first

  g.set(first, true)
  check g.get(first) == true

  g.swap(first, last)
  check g.get(last) == true

  g.fill(false)
  check g.get(last) == false
  g.fill(first, last, false)
  check g.get(last) == false

  g.clear()
  check g.get(last) == false
  g.clear(first, last)
  check g.get(last) == false

  g.enclose(true)
  check g.get(last) == true
  g.enclose(first, last, true)
  check g.get(last) == true

  g.clear()
  check g.isEmpty(first) == true
  check g.isInside(first) == true
  check g == newBGrid(size)

  for cell in g:
    check cell == false
  for i, cell in g:
    check cell == false
