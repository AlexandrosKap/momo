from strformat import `&`
from math import floor, ceil, sqrt, arctan2
import private/common

type
  GVec2*[T: SomeNumber] = object
    x*, y*: T
  IVec2* = GVec2[int32]
  UVec2* = GVec2[uint32]
  Vec2* = GVec2[float32]
  DVec2* = GVec2[float64]

  GVec3*[T: SomeNumber] = object
    x*, y*, z*: T
  IVec3* = GVec3[int32]
  UVec3* = GVec3[uint32]
  Vec3* = GVec3[float32]
  DVec3* = GVec3[float64]

  GVec4*[T: SomeNumber] = object
    x*, y*, z*, w*: T
  IVec4* = GVec4[int32]
  UVec4* = GVec4[uint32]
  Vec4* = GVec4[float32]
  DVec4* = GVec4[float64]

  SomeVec23*[T: SomeNumber] = GVec2[T] | GVec3[T]
  SomeVec34*[T: SomeNumber] = GVec3[T] | GVec4[T]
  SomeVec234*[T: SomeNumber] = GVec2[T] | GVec3[T] | GVec4[T]

# Helper Templates

template genCon[T: SomeNumber](name: untyped) =
  ## Generates constructors for a specific type for every vector type.
  func `name 2`*(x, y: T): GVec2[T] =
    GVec2[T](x: x, y: y)

  func `name 2`*(x: T): GVec2[T] =
    GVec2[T](x: x, y: x)

  func `name 2`*(): GVec2[T] =
    GVec2[T]()

  func `name 2`*[V: SomeNumber](vec: GVec2[V]): GVec2[T] =
    GVec2[T](x: T(vec.x), y: T(vec.y))

  func `name 3`*(x, y, z: T): GVec3[T] =
    GVec3[T](x: x, y: y, z: z)

  func `name 3`*(x: T): GVec3[T] =
    GVec3[T](x: x, y: x, z: x)

  func `name 3`*(): GVec3[T] =
    GVec3[T]()

  func `name 3`*[V: SomeNumber](vec: GVec3[V]): GVec3[T] =
    GVec3[T](x: T(vec.x), y: T(vec.y), z: T(vec.z))

  func `name 4`*(x, y, z, w: T): GVec4[T] =
    GVec4[T](x: x, y: y, z: z, w: w)

  func `name 4`*(x: T): GVec4[T] =
    GVec4[T](x: x, y: x, z: x, w: x)

  func `name 4`*(): GVec4[T] =
    GVec4[T]()

  func `name 4`*[V: SomeNumber](vec: GVec4[V]): GVec4[T] =
    GVec4[T](x: T(vec.x), y: T(vec.y), z: T(vec.z), w: T(vec.w))

template genOp(op: untyped) =
  ## Generates operator functions for every vector type.
  func op*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
    GVec2[T](x: op(a.x, b.x), y: op(a.y, b.y))

  func op*[T, V: SomeNumber](a: GVec2[T], b: V): GVec2[T] =
    GVec2[T](x: op(a.x.V, b).T, y: op(a.y.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GVec2[T]): GVec2[T] =
    GVec2[T](x: op(a.x.V, b).T, y: op(a.y.V, b).T)

  func op*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
    GVec3[T](x: op(a.x, b.x), y: op(a.y, b.y), z: op(a.z, b.z))

  func op*[T, V: SomeNumber](a: GVec3[T], b: V): GVec3[T] =
    GVec3[T](x: op(a.x.V, b).T, y: op(a.y.V, b).T, z: op(a.z.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GVec3[T]): GVec3[T] =
    GVec3[T](x: op(a.x.V, b).T, y: op(a.y.V, b).T, z: op(a.z.V, b).T)

  func op*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
    GVec4[T](
      x: op(a.x, b.x),
      y: op(a.y, b.y),
      z: op(a.z, b.z),
      w: op(a.w, b.w)
    )

  func op*[T, V: SomeNumber](a: GVec4[T], b: V): GVec4[T] =
    GVec4[T](
      x: op(a.x.V, b).T,
      y: op(a.y.V, b).T,
      z: op(a.z.V, b).T,
      w: op(a.w.V, b).T
    )

  func op*[T, V: SomeNumber](b: V, a: GVec4[T]): GVec4[T] =
    GVec4[T](
      x: op(a.x.V, b).T,
      y: op(a.y.V, b).T,
      z: op(a.z.V, b).T,
      w: op(a.w.V, b).T
    )

template genEqOp(op: untyped) =
  ## Generates equality operator functions for every vector type.
  func op*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
    op(a.x, b.x)
    op(a.y, b.y)

  func op*[T, V: SomeNumber](a: var GVec2[T], b: V) =
    a.x = op(a.x.V, b).T
    a.y = op(a.y.V, b).T

  func op*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)

  func op*[T, V: SomeNumber](a: var GVec3[T], b: V) =
    a.x = op(a.x.V, b).T
    a.y = op(a.y.V, b).T
    a.z = op(a.z.V, b).T

  func op*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)
    op(a.w, b.w)

  func op*[T, V: SomeNumber](a: var GVec4[T], b: V) =
    a.x = op(a.x.V, b).T
    a.y = op(a.y.V, b).T
    a.z = op(a.z.V, b).T
    a.w = op(a.w.V, b).T

# Constructors and Operators

func gvec2*[T: SomeNumber](x, y: T): GVec2[T] =
  GVec2[T](x: x, y: y)

func gvec2*[T: SomeNumber](x: T): GVec2[T] =
  GVec2[T](x: x, y: x)

func gvec2*[T: SomeNumber](): GVec2[T] =
  GVec2[T]()

func gvec3*[T: SomeNumber](x, y, z: T): GVec3[T] =
  GVec3[T](x: x, y: y, z: z)

func gvec3*[T: SomeNumber](x: T): GVec3[T] =
  GVec3[T](x: x, y: x, z: x)

func gvec3*[T: SomeNumber](): GVec3[T] =
  GVec3[T]()

func gvec4*[T: SomeNumber](x, y, z, w: T): GVec4[T] =
  GVec4[T](x: x, y: y, z: z, w: w)

func gvec4*[T: SomeNumber](x: T): GVec4[T] =
  GVec4[T](x: x, y: x, z: x, w: x)

func gvec4*[T: SomeNumber](): GVec4[T] =
  GVec4[T]()

genCon[int32](ivec)
genCon[uint32](uvec)
genCon[float32](vec)
genCon[float64](dvec)

genOp(`+`)
genOp(`-`)
genOp(`*`)
genOp(`/`)
genOp(`div`)
genOp(`mod`)

genEqOp(`+=`)
genEqOp(`-=`)
genEqOp(`*=`)
genEqOp(`/=`)
genEqOp(`div=`)
genEqOp(`mod=`)

# Functions

func angle*[T: SomeFloat](self: GVec2[T]): T =
  ## Returns the angle of the vector, in radians.
  arctan2(self.y, self.x)

func angle*[T: SomeFloat](self, vec: GVec2[T]): T =
  ## Returns the angle between two vectors, in radians.
  arctan2(self.y - vec.y, self.x - vec.x)

func length*[T: SomeFloat](self: GVec2[T]): T =
  ## Returns the length (magnitude) of the vector.
  sqrt(self.x * self.x + self.y * self.y)

func length*[T: SomeFloat](self: GVec3[T]): T =
  ## Returns the length (magnitude) of the vector.
  sqrt(self.x * self.x + self.y * self.y + self.z * self.z)

func length*[T: SomeFloat](self: GVec4[T]): T =
  ## Returns the length (magnitude) of the vector.
  sqrt(self.x * self.x + self.y * self.y + self.z * self.z, + self.w * self.w)

func dot*[T: SomeNumber](self, vec: GVec2[T]): T =
  ## Returns the dot product of two vectors.
  self.x * vec.x + self.y * vec.y

func dot*[T: SomeNumber](self, vec: GVec3[T]): T =
  ## Returns the dot product of two vectors.
  self.x * vec.x + self.y * vec.y + self.z * vec.z

func dot*[T: SomeNumber](self, vec: GVec4[T]): T =
  ## Returns the dot product of two vectors.
  self.x * vec.x + self.y * vec.y + self.z * vec.z + self.w * vec.w

func abs*[T: SomeSignedNumber](self: GVec2[T]): GVec2[T] =
  ## Returns the vector with all components in absolute values.
  GVec2[T](x: abs(self.x), y: abs(self.y))

func abs*[T: SomeSignedNumber](self: GVec3[T]): GVec3[T] =
  ## Returns the vector with all components in absolute values.
  GVec3[T](x: abs(self.x), y: abs(self.y), z: abs(self.z))

func abs*[T: SomeSignedNumber](self: GVec4[T]): GVec4[T] =
  ## Returns the vector with all components in absolute values.
  GVec4[T](x: abs(self.x), y: abs(self.y), z: abs(self.z), w: abs(self.w))

func floor*[T: SomeFloat](self: GVec2[T]): GVec2[T] =
  ## Returns the vector with all components rounded down.
  GVec2[T](x: floor(self.x), y: floor(self.y))

func floor*[T: SomeFloat](self: GVec3[T]): GVec3[T] =
  ## Returns the vector with all components rounded down.
  GVec3[T](x: floor(self.x), y: floor(self.y), z: floor(self.z))

func floor*[T: SomeFloat](self: GVec4[T]): GVec4[T] =
  ## Returns the vector with all components rounded down.
  GVec4[T](x: floor(self.x), y: floor(self.y), z: floor(self.z), w: floor(self.w))

func ceil*[T: SomeFloat](self: GVec2[T]): GVec2[T] =
  ## Returns the vector with all components rounded up.
  GVec2[T](x: ceil(self.x), y: ceil(self.y))

func ceil*[T: SomeFloat](self: GVec3[T]): GVec3[T] =
  ## Returns the vector with all components rounded up.
  GVec3[T](x: ceil(self.x), y: ceil(self.y), z: ceil(self.z))

func ceil*[T: SomeFloat](self: GVec4[T]): GVec4[T] =
  ## Returns the vector with all components rounded up.
  GVec4[T](x: ceil(self.x), y: ceil(self.y), z: ceil(self.z), w: ceil(self.w))

func normalized*[T: SomeFloat, V: SomeVec234[T]](self: V): V =
  ## Returns the vector scaled to unit length.
  self / self.length()

func distance*[T: SomeFloat, V: SomeVec234[T]](self, vec: V): V =
  ## Returns the distance between two vectors.
  (vec - self).abs()

func direction*[T: SomeFloat, V: SomeVec234[T]](self, vec: V): V =
  ## Returns the normalized vector pointing from self to vec.
  (vec - self).normalized()

func neighbors*[T: SomeSignedNumber](self: GVec2[T]): array[9, GVec2[T]] =
  ## Returns the adjacent vectors of the given vector as an array.
  ## The array is 3 ** 2 in length
  ## and contains the given vector so it can be used as a 2D array.
  result = array[9, GVec2[T]].default
  var i = 0
  for y in -1.T .. 1.T:
    for x in -1.T .. 1.T:
      result[i] = GVec2[T](
        x: self.x + x,
        y: self.y + y
      )
      i += 1

func neighbors*[T: SomeSignedNumber](self: GVec3[T]): array[27, GVec3[T]] =
  ## Returns the adjacent vectors of the given vector as an array.
  ## The array is 3 ** 3 in length
  ## and contains the given vector so it can be used as a 3D array.
  result = array[27, GVec3[T]].default
  var i = 0
  for z in -1.T .. 1.T:
    for y in -1.T .. 1.T:
      for x in -1.T .. 1.T:
        result[i] = GVec3[T](
          x: self.x + x,
          y: self.y + y,
          z: self.z + z
        )
        i += 1

func neighbors*[T: SomeSignedNumber](self: GVec4[T]): array[81, GVec4[T]] =
  ## Returns the adjacent vectors of the given vector as an array.
  ## The array is 3 ** 4 in length
  ## and contains the given vector so it can be used as a 4D array.
  result = array[81, GVec4[T]].default
  var i = 0
  for w in -1.T .. 1.T:
    for z in -1.T .. 1.T:
      for y in -1.T .. 1.T:
        for x in -1.T .. 1.T:
          result[i] = GVec4[T](
            x: self.x + x,
            y: self.y + y,
            z: self.z + z,
            w: self.w + w
          )
          i += 1

func `-`*[T: SomeSignedNumber](a: GVec2[T]): GVec2[T] =
  GVec2[T](x: -a.x, y: -a.y)

func `-`*[T: SomeSignedNumber](a: GVec3[T]): GVec3[T] =
  GVec3[T](x: -a.x, y: -a.y, z: -a.z)

func `-`*[T: SomeSignedNumber](a: GVec4[T]): GVec4[T] =
  GVec4[T](x: -a.x, y: -a.y, z: -a.z, w: -a.w)

func `==`*[T: SomeNumber](a, b: GVec2[T]): bool =
  a.x == b.x and a.y == b.y

func `==`*[T: SomeNumber](a, b: GVec3[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z

func `==`*[T: SomeNumber](a, b: GVec4[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w

func `!=`*[T: SomeNumber](a, b: GVec2[T]): bool =
  a.x != b.x or a.y != b.y

func `!=`*[T: SomeNumber](a, b: GVec3[T]): bool =
  a.x != b.x or a.y != b.y or a.z != b.z

func `!=`*[T: SomeNumber](a, b: GVec4[T]): bool =
  a.x != b.x or a.y != b.y or a.z != b.z or a.w != b.w

func `$`*[T: SomeNumber](self: GVec2[T]): string =
  &"({self.x}, {self.y})"

func `$`*[T: SomeNumber](self: GVec3[T]): string =
  &"({self.x}, {self.y}, {self.z})"

func `$`*[T: SomeNumber](self: GVec4[T]): string =
  &"({self.x}, {self.y}, {self.z}, {self.w})"
