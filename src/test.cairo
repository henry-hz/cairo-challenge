%builtins output range_check

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem

from starkware.cairo.common.uint256 import (
  Uint256,
  uint256_add,
)
from math import SafeUint256



// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

const UNIT   = 100000;   // decimal precision
const GUESS  = 100000;   // first guess
const CYCLE  = 4;        // fixed cycles to run

func fibo(n : felt) -> (result: felt) {
    alloc_locals;
    if (n == 0) {
      return (result=0);
    }
    if (n == 1) {
      return (result=1);
    }
    let (local x) = fibo(n - 1);
    let (local y) = fibo(n - 2);
    return (result = x + y);
}

func sqrt{range_check_ptr}(n: felt, s: felt) -> (result: felt) {
    alloc_locals;
    if (n == 0) {
        return (result=1);
    }

    let c = n - 1;
    let (local x1) = sqrt(s,c);
    let (local x2) = sqrt(s,c);
    let (q,r) = unsigned_div_rem((x1 + s/x2), 2);
    return (result=q);
}

func array_sum(arr: felt*, size) -> felt {
    if (size == 0) {
        return 0;
    }

    // size is not zero.
    let sum_of_rest = array_sum(arr=arr + 1, size=size - 1);
    return arr[0] + sum_of_rest;
}


func main{output_ptr: felt*, range_check_ptr}() {
    //let (x) = fibo(10);
    let (y) = sqrt(5, 16);
    //assert x = 55;
    serialize_word(y);
    return ();
}

