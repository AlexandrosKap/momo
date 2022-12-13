type
  GVec2*[T] = tuple
    x, y: T
  BVec2* = GVec2[bool]
  IVec2* = GVec2[int32]
  UVec2* = GVec2[uint32]
  Vec2* = GVec2[float32]
  DVec2* = GVec2[float64]

  GVec3*[T] = tuple
    x, y, z: T
  BVec3* = GVec3[bool]
  IVec3* = GVec3[int32]
  UVec3* = GVec3[uint32]
  Vec3* = GVec3[float32]
  DVec3* = GVec3[float64]

  GVec4*[T] = tuple
    x, y, z, w: T
  BVec4* = GVec4[bool]
  IVec4* = GVec4[int32]
  UVec4* = GVec4[uint32]
  Vec4* = GVec4[float32]
  DVec4* = GVec4[float64]

func gvec2*[T](x, y: T): GVec2[T] = (x, y)
func bvec2*(x, y: bool): BVec2 = (x, y)
func ivec2*(x, y: int32): IVec2 = (x, y)
func uvec2*(x, y: uint32): UVec2 = (x, y)
func vec2*(x, y: float32): Vec2 = (x, y)
func dvec2*(x, y: float64): DVec2 = (x, y)

#

func gvec3*[T](x, y, z: T): GVec3[T] = (x, y, z)
func bvec3*(x, y, z: bool): BVec3 = (x, y, z)
func ivec3*(x, y, z: int32): IVec3 = (x, y, z)
func uvec3*(x, y, z: uint32): UVec3 = (x, y, z)
func vec3*(x, y, z: float32): Vec3 = (x, y, z)
func dvec3*(x, y, z: float64): DVec3 = (x, y, z)

#

func gvec4*[T](x, y, z, w: T): GVec4[T] = (x, y, z, w)
func bvec4*(x, y, z, w: bool): BVec4 = (x, y, z, w)
func ivec4*(x, y, z, w: int32): IVec4 = (x, y, z, w)
func uvec4*(x, y, z, w: uint32): UVec4 = (x, y, z, w)
func vec4*(x, y, z, w: float32): Vec4 = (x, y, z, w)
func dvec4*(x, y, z, w: float64): DVec4 = (x, y, z, w)

#

func `+`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x + b.x, a.y + b.y)

func `-`*[T](a: GVec2[T]): GVec2[T] =
  (-a.x, -a.y)

func `-`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x - b.x, a.y - b.y)

func `*`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x * b.x, a.y * b.y)

func `/`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x / b.x, a.y / b.y)

func `mod`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x mod b.x, a.y mod b.y)

func `div`*[T](a, b: GVec2[T]): GVec2[T] =
  (a.x div b.x, a.y div b.y)

#

func `+`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x + b.x, a.y + b.y, a.z + b.z)

func `-`*[T](a: GVec3[T]): GVec3[T] =
  (-a.x, -a.y, -a.z)

func `-`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x - b.x, a.y - b.y, a.z - b.z)

func `*`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x * b.x, a.y * b.y, a.z * b.z)

func `/`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x / b.x, a.y / b.y, a.z / b.z)

func `mod`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x mod b.x, a.y mod b.y, a.z mod b.z)

func `div`*[T](a, b: GVec3[T]): GVec3[T] =
  (a.x div b.x, a.y div b.y, a.z div b.z)

#

func `+`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)

func `-`*[T](a: GVec4[T]): GVec4[T] =
  (-a.x, -a.y, -a.z, -a.w)

func `-`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)

func `*`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)

func `/`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)

func `mod`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x mod b.x, a.y mod b.y, a.z mod b.z, a.w mod b.w)

func `div`*[T](a, b: GVec4[T]): GVec4[T] =
  (a.x div b.x, a.y div b.y, a.z div b.z, a.w div b.w)
