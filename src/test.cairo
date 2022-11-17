%builtins output range_check

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.uint256 import (Uint256,uint256_add, uint256_mul)
from math import SafeUint256

const FULL_RING = 2 ** 251 + 17 * 2 ** 192 +1;
const STEPS = 10;
const PRECISION_L = 10**38;
const PRECISION_H = 0;


func sqrt_hp{range_check_ptr}(n: felt, s: Uint256) -> (result: Uint256) {
    alloc_locals;
    let WAD = Uint256(low=PRECISION_L, high=PRECISION_H);

    if (n == 0) {
        return (result = WAD);
    }
    let (x:  Uint256) = sqrt_hp(n - 1, s);
    let (q1: Uint256) = SafeUint256.wdiv(s, x);
    let (r1: Uint256) = SafeUint256.add(x, q1);
    let (w2: Uint256) = SafeUint256.add(WAD, WAD);
    let (q2: Uint256) = SafeUint256.wdiv(r1, w2);
    return(result = q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    let WAD   = Uint256(low=PRECISION_L, high=PRECISION_H);
    let (two) = SafeUint256.add(WAD, WAD);

    let (y4: Uint256) = sqrt_hp(STEPS, two);
    let (p1, p2) = unsigned_div_rem(11,3);
    let p3 = 1/3;
    let j = 2 ** 251 + 17 * 2 ** 192 +1;
    let j1 = j/2;
    serialize_word(j1);
    //assert y4.low = 141421356237309504880168872420969807857;

    let num1 = Uint256(low=13,high=0);
    let num2 = Uint256(low=7,high=0);
    let (mul_low: Uint256, mul_high: Uint256) = uint256_mul(num1, num2);
    //serialize_word(mul_high.low);
    //serialize_word(mul_high.high);
    return ();
}
