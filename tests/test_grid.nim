import unittest
import momo/grid

const width = 4
const height = 4
const first = gridPoint()
const last = gridPoint(width - 1, height - 1)

test "Grid":
  check gridPoint(0, 0) == GridPoint(x: 0, y: 0)
  check gridPoint(0) == gridPoint(0, 0)
  check gridPoint() == gridPoint(0)

  var g = newBGrid(width, height)
  check g.width == width
  check g.height == height
  check g.cells == newSeq[bool](width * height)
  check g.len == width * height
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
  check g == newBGrid(width, height)

  for cell in g:
    check cell == false
  for i, cell in g:
    check cell == false
