import unittest
import momo/grid

const width = 4
const height = 4

test "Grid":
  check gridPoint(0, 0) == GridPoint(x: 0, y: 0)
  check gridPoint(0) == gridPoint(0, 0)
  check gridPoint() == gridPoint(0)

  check newBGrid(1, 1, true).cells == @[true]
  check newBGrid(1, 1).cells == @[false]

  var g = newBGrid(width, height)
  check g.width == width
  check g.height == height
  check g.cells == newSeq[bool](width * height)
  check g.len == width * height

  check g.id(0, 0) == 0
  check g.id(gridPoint()) == 0

  check g.point(0) == gridPoint()

  g.set(0, true)
  g.set(0, 0, true)
  g.set(gridPoint(), true)
  check g.get(0) == true
  check g.get(0, 0) == true
  check g.get(gridPoint()) == true

  g.swap(0, g.len - 1)
  g.swap(0, 0, g.width - 1, g.height - 1)
  g.swap(gridPoint(), gridPoint(g.width - 1, g.height - 1))
  check g.get(g.width - 1, g.height - 1) == true

  g.fill(false)
  g.fill(0, 0, g.width - 1, g.height - 1, false)
  g.fill(gridPoint(), gridPoint(g.width - 1, g.height - 1), false)
  g.fill(0, g.len - 1, false)
  check g.get(g.width - 1, g.height - 1) == false

  g.enclose(true)
  g.enclose(0, 0, g.width - 1, g.height - 1, true)
  g.enclose(gridPoint(), gridPoint(g.width - 1, g.height - 1), true)
  g.enclose(0, g.len - 1, true)
  check g.get(0) == true

  g.clear()
  g.clear(0, 0, g.width - 1, g.height - 1)
  g.clear(gridPoint(), gridPoint(g.width - 1, g.height - 1))
  g.clear(0, g.len - 1)
  check g.get(0) == false

  check g.isEmpty(0) == true
  check g.isEmpty(0, 0) == true
  check g.isEmpty(gridPoint()) == true

  check g.isInside(0) == true
  check g.isInside(0, 0) == true
  check g.isInside(gridPoint()) == true

  check g == newBGrid(width, height)

  for cell in g:
    check cell == false
  for i, cell in g:
    check cell == false
