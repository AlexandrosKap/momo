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

# Constructors for GVec2

func gvec2*[T](x, y: T): GVec2[T] = (x, y)
func bvec2*(x, y: bool): BVec2 = (x, y)
func ivec2*(x, y: int32): IVec2 = (x, y)
func uvec2*(x, y: uint32): UVec2 = (x, y)
func vec2*(x, y: float32): Vec2 = (x, y)
func dvec2*(x, y: float64): DVec2 = (x, y)

#

func gvec2*[T](x: T): GVec2[T] = (x, x)
func bvec2*(x: bool): BVec2 = (x, x)
func ivec2*(x: int32): IVec2 = (x, x)
func uvec2*(x: uint32): UVec2 = (x, x)
func vec2*(x: float32): Vec2 = (x, x)
func dvec2*(x: float64): DVec2 = (x, x)

#

func gvec2*[T](): GVec2[T] = (T.default, T.default)
func bvec2*(): BVec2 = (false, false)
func ivec2*(): IVec2 = (0i32, 0i32)
func uvec2*(): UVec2 = (0u32, 0u32)
func vec2*(): Vec2 = (0f32, 0f32)
func dvec2*(): DVec2 = (0f64, 0f64)

# Constructors for GVec3

func gvec3*[T](x, y, z: T): GVec3[T] = (x, y, z)
func bvec3*(x, y, z: bool): BVec3 = (x, y, z)
func ivec3*(x, y, z: int32): IVec3 = (x, y, z)
func uvec3*(x, y, z: uint32): UVec3 = (x, y, z)
func vec3*(x, y, z: float32): Vec3 = (x, y, z)
func dvec3*(x, y, z: float64): DVec3 = (x, y, z)

#

func gvec3*[T](x: T): GVec3[T] = (x, x, x)
func bvec3*(x: bool): BVec3 = (x, x, x)
func ivec3*(x: int32): IVec3 = (x, x, x)
func uvec3*(x: uint32): UVec3 = (x, x, x)
func vec3*(x: float32): Vec3 = (x, x, x)
func dvec3*(x: float64): DVec3 = (x, x, x)

#

func gvec3*[T](): GVec3[T] = (T.default, T.default, T.default)
func bvec3*(): BVec3 = (false, false, false)
func ivec3*(): IVec3 = (0i32, 0i32, 0i32)
func uvec3*(): UVec3 = (0u32, 0u32, 0u32)
func vec3*(): Vec3 = (0f32, 0f32, 0f32)
func dvec3*(): DVec3 = (0f64, 0f64, 0f64)

# Constructors for GVec4

func gvec4*[T](x, y, z, w: T): GVec4[T] = (x, y, z, w)
func bvec4*(x, y, z, w: bool): BVec4 = (x, y, z, w)
func ivec4*(x, y, z, w: int32): IVec4 = (x, y, z, w)
func uvec4*(x, y, z, w: uint32): UVec4 = (x, y, z, w)
func vec4*(x, y, z, w: float32): Vec4 = (x, y, z, w)
func dvec4*(x, y, z, w: float64): DVec4 = (x, y, z, w)

#

func gvec4*[T](x: T): GVec4[T] = (x, x, x, x)
func bvec4*(x: bool): BVec4 = (x, x, x, x)
func ivec4*(x: int32): IVec4 = (x, x, x, x)
func uvec4*(x: uint32): UVec4 = (x, x, x, x)
func vec4*(x: float32): Vec4 = (x, x, x, x)
func dvec4*(x: float64): DVec4 = (x, x, x, x)

#

func gvec4*[T](): GVec4[T] = (T.default, T.default, T.default, T.default)
func bvec4*(): BVec4 = (false, false, false, false)
func ivec4*(): IVec4 = (0i32, 0i32, 0i32, 0i32)
func uvec4*(): UVec4 = (0u32, 0u32, 0u32, 0u32)
func vec4*(): Vec4 = (0f32, 0f32, 0f32, 0f32)
func dvec4*(): DVec4 = (0f64, 0f64, 0f64, 0f64)

# Operators for GVec2

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

# Operators for GVec3

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

# Operators for GVec4

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
