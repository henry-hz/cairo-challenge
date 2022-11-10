%builtins output range_check

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.uint256 import (Uint256,uint256_add)
from math import SafeUint256

const STEPS = 20;

const WAD = 10 ** 2;
const RAY = 10 ** 27;
const RAD = 10 ** 45;

func sqrt{range_check_ptr}(n: felt, s: felt) -> (result: felt) {
    alloc_locals;
    if (n == 0) {
        return (result=1);
    }

    let (local x) = sqrt(n - 1, s);
    let (q1, r1) = unsigned_div_rem(s, x);
    let (q2, r2) = unsigned_div_rem((x + q1), 2);
    return (result=q2);
}

func sqrt_hp{range_check_ptr}(n: felt, s: Uint256) -> (result: Uint256) {
    alloc_locals;
    if (n == 0) {
        return (result = Uint256(1,0));
    }

    // steps
    let (x: Uint256) = sqrt_hp(n - 1, s);

    // boost precision
    let (s1: Uint256) = SafeUint256.mul(s, Uint256(WAD,0));
    let (x1: Uint256) = SafeUint256.mul(x, Uint256(WAD,0));

    // calculate
    let (q1: Uint256) = SafeUint256.warp_div256(s1, x1);

    // low precision
    let (q3: Uint256) = SafeUint256.warp_div256(q1, Uint256(WAD,0));
    let (x2: Uint256) = SafeUint256.warp_div256(x1, Uint256(WAD,0));

    let (r1: Uint256) = SafeUint256.add(x2, q3);
    let (q2: Uint256) = SafeUint256.warp_div256(r1, Uint256(2,0));
    return(result = q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    // low precision
    let (y) = sqrt(STEPS, 16);
    assert y = 4;
    serialize_word(y);

    // high precision
    let (y1: Uint256) = sqrt_hp(STEPS, Uint256(16,0));
    //assert y1 = Uint256(4,0);
    serialize_word(y1.low);
    serialize_word(y1.high);
    serialize_word(RAY);
    return ();
}



