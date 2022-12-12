from strutils import fromHex

type
  Color* = object
    r, g, b, a: uint8
  Palette* = seq[Color]
  Grayscale* = seq[uint8]

func toByte*(hex: string): uint8 =
  try:
    fromHex[uint8](hex)
  except ValueError:
    uint8.low

func color*(r, g, b, a: uint8): Color = Color(r: r, g: g, b: b, a: a)
func color*(r, g, b: uint8): Color = color(r, g, b, uint8.high)
func color*(gray: uint8): Color = color(gray, gray, gray)
func color*(hex: string): Color =
  let str =
    if hex.len > 1 and hex[0] == '#': hex[1 ..< hex.len]
    else: hex
  case str.len:
  of 6: color(
    str[0 .. 1].toByte,
    str[2 .. 3].toByte,
    str[4 .. 5].toByte
  )
  of 8: color(
    str[2 .. 3].toByte,
    str[4 .. 5].toByte,
    str[6 .. 7].toByte,
    str[0 .. 1].toByte
  )
  else: color(0)

const red* = color(255, 0, 0)
const green* = color(0, 255, 0)
const blue* = color(0, 0, 255)
const blank* = color(0, 0, 0, 0)
const black* = color(0)
const white* = color(255)

const bitbit* = static([
  color("000000"), color("676767"), color("b6b6b6"), color("ffffff"),
])

const pocket* = static([
  color("2b2b26"), color("706b66"), color("a89f94"), color("e0dbcd"),
])

const gameboy* = static([
  color("081820"), color("346856"), color("88c070"), color("e0f8d0"),
])

const pokemon* = static([
  color("181010"), color("84739c"), color("f7b58c"), color("ffefff"),
])
