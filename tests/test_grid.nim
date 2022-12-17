import unittest
import momo/grid

const width = 3
const height = 3
const firstPoint = point(0, 0)
const lastPoint = point(width - 1, height - 1)
const cells = array[width * height, bool].default

test "Grid":
  check point(2, 4) == Point(x: 2, y: 4)
  check point(1) == point(1, 1)
  check point() == point(0)

  var grid = newBGrid(width, height, true)
  check grid.width == width
  check grid.height == height
  check grid.len == width * height
  check grid.cells != cells
  grid = newBGrid(width, height)
  check grid.cells == cells

  check grid.id(firstPoint) == 0
  check grid.id(lastPoint) == grid.len - 1
  check grid.point(grid.len - 1) == lastPoint

  check grid.get(firstPoint) == false
  grid.set(firstPoint, true)
  check grid.get(firstPoint) == true

  grid.swap(firstPoint, lastPoint)
  check grid.get(0) == false

  grid.fill(true)
  for cell in grid.cells:
    check cell == true
  grid.fill(0, grid.len - 1, false)
  for cell in grid.cells:
    check cell == false

  grid.enclose(0, grid.len - 1, true)
  for y in 0 ..< grid.height:
    check grid.get(0, y) == true
    check grid.get(grid.width - 1, y) == true
  for x in 0 ..< grid.width:
    check grid.get(x, 0) == true
    check grid.get(x, grid.height - 1) == true

  grid.set(0, 0, true)
  grid.clear()
  for cell in grid.cells:
    check cell == false
  grid.set(0, 0, true)
  grid.clear(0, grid.len - 1)
  for cell in grid.cells:
    check cell == false

  check grid.isEmpty(lastPoint) == true
  grid.set(grid.len - 1, true)
  check grid.isEmpty(lastPoint) == false
  grid.clear()

  check grid.isInside(width, height) == false
  check grid.isInside(firstPoint) == true
  check grid.isInside(point(width, height)) == false
  check grid.isInside(point(-1, 0)) == false

  for cell in grid:
    check cell == false
  for i, cell in grid:
    check cell == false
