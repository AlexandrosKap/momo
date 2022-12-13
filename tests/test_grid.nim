import unittest
import momo/grid

const width = 2
const height = 2
const area = width * height
const firstPoint = (0, 0)
const secondPoint = (1, 0)
const lastPoint = (width - 1, height - 1)
const cells = array[area, bool].default

proc grid(): BGrid = newBGrid(width, height)

test "Grid":
  let grid = grid()
  check point(2, 4) == (2, 4)
  check point(1) == (1, 1)
  check point() == (0, 0)

  check grid.width == width
  check grid.height == height
  check grid.cells == cells
  check grid.len == area

  check grid.id(0, 0) == 0
  check grid.id(firstPoint) == 0
  check grid.id(width - 1, height - 1) == area - 1
  check grid.id(lastPoint) == area - 1

  check grid.point(area - 1) == lastPoint

  grid.set(0, true)
  check grid.get(0) == true
  grid.set(0, 0, false)
  check grid.get(0, 0) == false
  grid.set(firstPoint, true)
  check grid.get(firstPoint) == true

  grid.swap(0, 1)
  check grid.get(0) == false
  grid.swap(0, 0, 1, 0)
  check grid.get(0) == true
  grid.swap(firstPoint, secondPoint)
  check grid.get(0) == false

  grid.fill(true)
  for cell in grid.cells:
    check cell == true
  grid.fill(0, area - 1, false)
  for cell in grid.cells:
    check cell == false
  grid.fill(0, 0, width - 1, height - 1, true)
  for cell in grid.cells:
    check cell == true
  grid.fill(firstPoint, lastPoint, false)
  for cell in grid.cells:
    check cell == false

  grid.set(0, 0, true)
  grid.clear()
  for cell in grid.cells:
    check cell == false
  grid.set(0, 0, true)
  grid.clear(0, area - 1)
  for cell in grid.cells:
    check cell == false
  grid.set(0, 0, true)
  grid.clear(0, 0, width - 1, height - 1)
  for cell in grid.cells:
    check cell == false
  grid.set(0, 0, true)
  grid.clear(firstPoint, lastPoint)
  for cell in grid.cells:
    check cell == false

  check grid.isEmpty(area - 1) == true
  check grid.isEmpty(width - 1, height - 1) == true
  check grid.isEmpty(lastPoint) == true
  grid.set(area - 1, true)
  check grid.isEmpty(area - 1) == false
  check grid.isEmpty(width - 1, height - 1) == false
  check grid.isEmpty(lastPoint) == false
  grid.clear()

  check grid.isInside(0) == true
  check grid.isInside(-1) == false
  check grid.isInside(area) == false
  check grid.isInside(0, 0) == true
  check grid.isInside(-1, 0) == false
  check grid.isInside(width, height) == false
  check grid.isInside(firstPoint) == true
  check grid.isInside((-1, 0)) == false
  check grid.isInside((width, height)) == false

  for cell in grid:
    check cell == false
  var count = 0
  for i, cell in grid:
    check (i, cell) == (count, false)
    count += 1
  count = 0
