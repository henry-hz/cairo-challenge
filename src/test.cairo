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
const CYCLE  = 400000;   // fixed cycles to run
const GUESS  = 100000;   // first guess
let u: Uint256 = Uint256(UNIT, 0);

func calc{range_check_ptr}(s: Uint256, x: Uint256) -> (res: Uint256) {
    let two: Uint256 = Uint256(2,0);
    let (r1: Uint256, rem: Uint256) = SafeUint256.div_rem(s, x);    // s/x
    let (r2: Uint256) = SafeUint256.add(x, r1);                     // x + s/x
    let (r3: Uint256, rem: Uint256) = SafeUint256.div_rem(r2, two); // (x + s/x) / 2
    return(res=r3);
}

func sqrt{range_check_ptr}(n: Uint256, s: Uint256) -> (res: Uint256) {
    let u: Uint256 = Uint256(UNIT, 0);
    let z: Uint256 = Uint256(0,0);
    let s: Uint256 = calc(n, s);
    let f = uint256_eq(n, z);
    //if () {
    //    return (res=res);
    //}
    return (res=z);
}

func mul{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
    uint256_check(a);
    let (c: Uint256) = SafeUint256.mul(a, b);
    return (c=c);
}


// decrease one UNIT point
func dec{range_check_ptr}(v: Uint256) -> (res: Uint256) {
    let u: Uint256 = Uint256(UNIT, 0);
    let res: Uint256 = SafeUint256.sub_le(v, u);
    return(res=res);
}

func div{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256, d: Uint256) {
    let (c: Uint256, d: Uint256) = SafeUint256.div_rem(a, b);
    return (c=c, d=d);
}


func main{output_ptr: felt*, range_check_ptr}() {

    let a: Uint256 = Uint256(3,0);
    let b: Uint256 = Uint256(3,0);
    let v: Uint256 = Uint256(6,0);
    let d: Uint256 = mul(a,b);

    let (is_eq: felt) = uint256_eq(a,d);

    serialize_word(3);

    return ();
}

