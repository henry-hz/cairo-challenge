%builtins output range_check

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.uint256 import (Uint256,uint256_add)
from math import SafeUint256

const STEPS = 35;
const WAD   = 10**30;


func sqrt_hp{range_check_ptr}(n: felt, s: Uint256) -> (result: Uint256) {
    alloc_locals;
    if (n == 0) {
        return (result = Uint256(WAD, 0));
    }
    let (x:  Uint256) = sqrt_hp(n - 1, s);
    let (q1: Uint256) = SafeUint256.wdiv(s, x);
    let (r1: Uint256) = SafeUint256.add(x, q1);
    let (q2: Uint256) = SafeUint256.wdiv(r1, Uint256(WAD + WAD, 0));
    return(result = q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    alloc_locals;
    let (y4: Uint256) = sqrt_hp(STEPS, Uint256(2*WAD,0));
    serialize_word(y4.low);
    //assert y4.low = 483977;
    return ();
}
