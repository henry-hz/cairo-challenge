%builtins output range_check

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.uint256 import (Uint256,uint256_add)
from math import SafeUint256

const STEPS = 30;
const WAD   = 10**5;


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

func sqrt_uint256{range_check_ptr}(n: felt, s: Uint256) -> (result: Uint256) {
    alloc_locals;
    if (n == 0) {
        return (result = Uint256(1,0));
    }
    let (x: Uint256) = sqrt_uint256(n - 1, s);
    let (q1: Uint256) = SafeUint256.warp_div256(s, x);
    let (r1: Uint256) = SafeUint256.add(x, q1);
    let (q2: Uint256) = SafeUint256.warp_div256(r1, Uint256(2,0));
    return(result = q2);
}

func sqrt_hp{range_check_ptr}(n: felt, s: Uint256) -> (result: Uint256) {
    alloc_locals;
    if (n == 0) {
        return (result = Uint256(1*WAD,0));
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

    // boost precision
    let (r2: Uint256) = SafeUint256.mul(r1, Uint256(WAD,0));
    let (two: Uint256) = SafeUint256.mul(Uint256(2,0), Uint256(WAD,0));

    let (q2: Uint256) = SafeUint256.warp_div256(r2, two);
    return(result = q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    // low precision
    let (y1) = sqrt(STEPS, 16);
    assert y1 = 4;
    serialize_word(y1);

    // use uint256
    let (y2: Uint256) = sqrt_uint256(STEPS, Uint256(234234234234,0));
    assert y2.low = 483977;
    serialize_word(y2.low);

    // use high precision
    let (y3: Uint256) = sqrt_hp(STEPS, Uint256(2*WAD,0));
    //assert y3.low = 1;
    serialize_word(y3.low);
    return ();
}

