%builtins output range_check

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.cairo_builtins import (HashBuiltin, BitwiseBuiltin)
from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.uint256 import (Uint256,uint256_add)
from math import SafeUint256

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

func sqrt{range_check_ptr}(n: felt, s: felt) -> (result: felt) {
    alloc_locals;
    if (n == 0) {
        return (result=1);
    }

    let (local x1) = sqrt(n - 1, s);
    let (q1, r1) = unsigned_div_rem(s,x1);
    let (q2, r2) = unsigned_div_rem((x1 + q1), 2);
    return (result=q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    // % steps
    let (y) = sqrt(10, 2000);
    //assert x = 55;
    serialize_word(y);
    return ();
}

