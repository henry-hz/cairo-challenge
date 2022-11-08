%lang starknet


from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_not_zero, assert_le
from starkware.cairo.common.math import unsigned_div_rem
from starkware.cairo.common.bool import TRUE, FALSE
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

func sqrt{range_check_ptr}(v: Uint256, size) -> (res: Uint256) {

    let res: Uint256 = sqrt(v, size=size - 1);
    if (size == 0) {
        return (res=res);
    }
    return (res=res);
}

func mul{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
    uint256_check(a);
    let (c: Uint256) = SafeUint256.mul(a, b);
    return (c=c);
}

func div{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256, d: Uint256) {
    let (c: Uint256, d: Uint256) = SafeUint256.div_rem(a, b);
    return (c=c, d=d);
}

func main{output_ptr: felt*, range_check_ptr}() {
    const CYCLES_SIZE = 4;

    let a: Uint256 = Uint256(3,0);
    let b: Uint256 = Uint256(3,0);
    let v: Uint256 = Uint256(6,0);
    let d: Uint256 = mul(a,b);

    let (is_eq: felt) = uint256_eq(a,d);

    serialize_word(3);

    return ();
}

