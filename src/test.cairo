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

let u: Uint256 = Uint256(UNIT, 0);

func calc{range_check_ptr}(s: Uint256, x: Uint256) -> (r: Uint256) {
    let two: Uint256 = Uint256(2,0);
    let (r1: Uint256, rem: Uint256) = SafeUint256.div_rem(s, x);    // s/x
    let (r2: Uint256) = SafeUint256.add(x, r1);                     // x + s/x
    let (r3: Uint256, rem: Uint256) = SafeUint256.div_rem(r2, two); // (x + s/x) / 2
    return(r=r3);
}

// n: the number of cycles to approximate the result
// s: the actual calculated sqrt
func sqrt{range_check_ptr}(n, s: Uint256) -> (r: Uint256) {
    let s: Uint256 = calc(s, calc(s));
    let u: Uint256 = Uint256(UNIT, 0);
    let z: Uint256 = Uint256(0,0);
    if (n == 0) {
        return (r=z);
    }
    return (r=z);
}

// decrease one point from cycle counter
func dec(c) -> felt {
    return c - 1;
}


func main{output_ptr: felt*, range_check_ptr}() {

    let a: Uint256 = Uint256(3,0);
    let b: Uint256 = Uint256(3,0);
    let v: Uint256 = Uint256(6,0);
    //let d: Uint256 = mul(a,b);

    //let (is_eq: felt) = uint256_eq(a,d);

    serialize_word(3);

    return ();
}

