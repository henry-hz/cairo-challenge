%lang starknet

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.cairo.common.math import unsigned_div_rem
from starkware.cairo.common.bool import TRUE, FALSE
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import (
    Uint256,
    uint256_check,
    uint256_add,
    uint256_sub,
    uint256_mul,
    uint256_unsigned_div_rem,
    uint256_le,
    uint256_lt,
    uint256_eq,
)
from math import SafeUint256
const UNIT   = 100000;   // decimal precision
const GUESS  = 100000;   // first guess
const CYCLE  = 4;        // fixed cycles to run

func fibonacci(n: felt) -> (result : felt) {
  alloc_locals
  if n == 0:
    return (0)
  end
  if n == 1:
    return (1)
  end
  let (local x) = fibonacci(n - 1)
  let (local y) = fibonacci(n - 2)
  return (x + y)
}


func sqrt(n: felt, s: felt) -> (r: felt) {
    alloc_locals;
}

// decrease one point from cycle counter
func dec(c) -> felt {
    return c - 1;
}


func main{output_ptr: felt*, range_check_ptr}() {

    serialize_word(3);

    return ();
}

