(module
 (type $_ (func))
 (type $iiii (func (param i32 i32 i32) (result i32)))
 (type $ii (func (param i32) (result i32)))
 (type $i_ (func (param i32)))
 (type $ifiiii_ (func (param i32 f32 i32 i32 i32 i32)))
 (type $iif (func (param i32 i32) (result f32)))
 (type $iiii_ (func (param i32 i32 i32 i32)))
 (type $iif_ (func (param i32 i32 f32)))
 (import "env" "abort" (func $~lib/env/abort (param i32 i32 i32 i32)))
 (memory $0 1)
 (data (i32.const 8) "\1b\00\00\00~\00l\00i\00b\00/\00i\00n\00t\00e\00r\00n\00a\00l\00/\00t\00y\00p\00e\00d\00a\00r\00r\00a\00y\00.\00t\00s\00")
 (table $0 1 funcref)
 (elem (i32.const 0) $null)
 (global $~lib/allocator/arena/startOffset (mut i32) (i32.const 0))
 (global $~lib/allocator/arena/offset (mut i32) (i32.const 0))
 (global $~lib/memory/HEAP_BASE i32 (i32.const 68))
 (export "memory" (memory $0))
 (export "table" (table $0))
 (export "memory.compare" (func $~lib/memory/memory.compare))
 (export "memory.allocate" (func $~lib/memory/memory.allocate))
 (export "memory.free" (func $~lib/memory/memory.free))
 (export "memory.reset" (func $~lib/memory/memory.reset))
 (export "saxpy" (func $src/saxpy/saxpy))
 (start $start)
 (func $start:~lib/allocator/arena (; 1 ;) (type $_)
  global.get $~lib/memory/HEAP_BASE
  i32.const 7
  i32.add
  i32.const 7
  i32.const -1
  i32.xor
  i32.and
  global.set $~lib/allocator/arena/startOffset
  global.get $~lib/allocator/arena/startOffset
  global.set $~lib/allocator/arena/offset
 )
 (func $start:assembly/index (; 2 ;) (type $_)
  call $start:~lib/allocator/arena
 )
 (func $~lib/internal/memory/memcmp (; 3 ;) (type $iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  local.get $0
  local.get $1
  i32.eq
  if
   i32.const 0
   return
  end
  block $break|0
   loop $continue|0
    local.get $2
    i32.const 0
    i32.ne
    local.tee $3
    if (result i32)
     local.get $0
     i32.load8_u
     local.get $1
     i32.load8_u
     i32.eq
    else     
     local.get $3
    end
    if
     block
      local.get $2
      i32.const 1
      i32.sub
      local.set $2
      local.get $0
      i32.const 1
      i32.add
      local.set $0
      local.get $1
      i32.const 1
      i32.add
      local.set $1
     end
     br $continue|0
    end
   end
  end
  local.get $2
  if (result i32)
   local.get $0
   i32.load8_u
   local.get $1
   i32.load8_u
   i32.sub
  else   
   i32.const 0
  end
 )
 (func $~lib/memory/memory.compare (; 4 ;) (type $iiii) (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  local.get $1
  local.get $2
  call $~lib/internal/memory/memcmp
 )
 (func $~lib/allocator/arena/__memory_allocate (; 5 ;) (type $ii) (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  i32.const 1073741824
  i32.gt_u
  if
   unreachable
  end
  global.get $~lib/allocator/arena/offset
  local.set $1
  local.get $1
  local.get $0
  local.tee $2
  i32.const 1
  local.tee $3
  local.get $2
  local.get $3
  i32.gt_u
  select
  i32.add
  i32.const 7
  i32.add
  i32.const 7
  i32.const -1
  i32.xor
  i32.and
  local.set $4
  current_memory
  local.set $5
  local.get $4
  local.get $5
  i32.const 16
  i32.shl
  i32.gt_u
  if
   local.get $4
   local.get $1
   i32.sub
   i32.const 65535
   i32.add
   i32.const 65535
   i32.const -1
   i32.xor
   i32.and
   i32.const 16
   i32.shr_u
   local.set $2
   local.get $5
   local.tee $3
   local.get $2
   local.tee $6
   local.get $3
   local.get $6
   i32.gt_s
   select
   local.set $3
   local.get $3
   grow_memory
   i32.const 0
   i32.lt_s
   if
    local.get $2
    grow_memory
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $4
  global.set $~lib/allocator/arena/offset
  local.get $1
 )
 (func $~lib/memory/memory.allocate (; 6 ;) (type $ii) (param $0 i32) (result i32)
  local.get $0
  call $~lib/allocator/arena/__memory_allocate
  return
 )
 (func $~lib/allocator/arena/__memory_free (; 7 ;) (type $i_) (param $0 i32)
  nop
 )
 (func $~lib/memory/memory.free (; 8 ;) (type $i_) (param $0 i32)
  local.get $0
  call $~lib/allocator/arena/__memory_free
  return
 )
 (func $~lib/allocator/arena/__memory_reset (; 9 ;) (type $_)
  global.get $~lib/allocator/arena/startOffset
  global.set $~lib/allocator/arena/offset
 )
 (func $~lib/memory/memory.reset (; 10 ;) (type $_)
  call $~lib/allocator/arena/__memory_reset
  return
 )
 (func $~lib/internal/typedarray/TypedArray<f32>#__get (; 11 ;) (type $iif) (param $0 i32) (param $1 i32) (result f32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 0
   i32.const 8
   i32.const 39
   i32.const 63
   call $~lib/env/abort
   unreachable
  end
  block $~lib/internal/arraybuffer/LOAD<f32,f32>|inlined.0 (result f32)
   local.get $0
   i32.load
   local.set $2
   local.get $1
   local.set $3
   local.get $0
   i32.load offset=4
   local.set $4
   local.get $2
   local.get $3
   i32.const 2
   i32.shl
   i32.add
   local.get $4
   i32.add
   f32.load offset=8
  end
 )
 (func $~lib/internal/typedarray/TypedArray<f32>#__set (; 12 ;) (type $iif_) (param $0 i32) (param $1 i32) (param $2 f32)
  (local $3 i32)
  (local $4 i32)
  (local $5 f32)
  (local $6 i32)
  local.get $1
  local.get $0
  i32.load offset=8
  i32.const 2
  i32.shr_u
  i32.ge_u
  if
   i32.const 0
   i32.const 8
   i32.const 50
   i32.const 63
   call $~lib/env/abort
   unreachable
  end
  block $~lib/internal/arraybuffer/STORE<f32,f32>|inlined.0
   local.get $0
   i32.load
   local.set $3
   local.get $1
   local.set $4
   local.get $2
   local.set $5
   local.get $0
   i32.load offset=4
   local.set $6
   local.get $3
   local.get $4
   i32.const 2
   i32.shl
   i32.add
   local.get $6
   i32.add
   local.get $5
   f32.store offset=8
  end
 )
 (func $src/saxpy/saxpy (; 13 ;) (type $ifiiii_) (param $0 i32) (param $1 f32) (param $2 i32) (param $3 i32) (param $4 i32) (param $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  local.get $0
  i32.const 0
  i32.lt_s
  if
   return
  end
  local.get $1
  f32.const 0
  f32.eq
  if
   return
  end
  local.get $3
  i32.const 1
  i32.eq
  local.tee $7
  if (result i32)
   local.get $5
   i32.const 1
   i32.eq
  else   
   local.get $7
  end
  if
   local.get $0
   i32.const 4
   i32.rem_s
   local.set $7
   local.get $7
   i32.const 0
   i32.ne
   if
    block $break|0
     i32.const 0
     local.set $6
     loop $repeat|0
      local.get $6
      local.get $7
      i32.lt_s
      i32.eqz
      br_if $break|0
      local.get $4
      local.get $6
      local.get $4
      local.get $6
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $6
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
      local.get $6
      i32.const 1
      i32.add
      local.set $6
      br $repeat|0
      unreachable
     end
     unreachable
    end
   end
   local.get $0
   i32.const 4
   i32.lt_s
   if
    return
   end
   block $break|1
    local.get $7
    local.set $6
    loop $repeat|1
     local.get $6
     local.get $0
     i32.lt_s
     i32.eqz
     br_if $break|1
     block
      local.get $4
      local.get $6
      local.get $4
      local.get $6
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $6
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
      local.get $4
      local.get $6
      i32.const 1
      i32.add
      local.get $4
      local.get $6
      i32.const 1
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $6
      i32.const 1
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
      local.get $4
      local.get $6
      i32.const 2
      i32.add
      local.get $4
      local.get $6
      i32.const 2
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $6
      i32.const 2
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
      local.get $4
      local.get $6
      i32.const 3
      i32.add
      local.get $4
      local.get $6
      i32.const 3
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $6
      i32.const 3
      i32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
     end
     local.get $6
     i32.const 4
     i32.add
     local.set $6
     br $repeat|1
     unreachable
    end
    unreachable
   end
  else   
   i32.const 1
   local.set $7
   i32.const 1
   local.set $8
   local.get $3
   i32.const 0
   i32.lt_s
   if
    i32.const 0
    local.get $0
    i32.sub
    local.get $3
    i32.mul
    local.set $7
   end
   local.get $5
   i32.const 0
   i32.lt_s
   if
    i32.const 0
    local.get $0
    i32.sub
    local.get $5
    i32.mul
    local.set $8
   end
   block $break|2
    i32.const 0
    local.set $6
    loop $repeat|2
     local.get $6
     local.get $0
     i32.lt_s
     i32.eqz
     br_if $break|2
     block
      local.get $4
      local.get $8
      local.get $4
      local.get $6
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      local.get $1
      local.get $2
      local.get $7
      call $~lib/internal/typedarray/TypedArray<f32>#__get
      f32.mul
      f32.add
      call $~lib/internal/typedarray/TypedArray<f32>#__set
      local.get $7
      local.get $3
      i32.add
      local.set $7
      local.get $8
      local.get $5
      i32.add
      local.set $8
     end
     local.get $6
     i32.const 1
     i32.add
     local.set $6
     br $repeat|2
     unreachable
    end
    unreachable
   end
  end
 )
 (func $start (; 14 ;) (type $_)
  call $start:assembly/index
 )
 (func $null (; 15 ;) (type $_)
 )
)
