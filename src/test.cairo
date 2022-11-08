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

// Computes the sum of the memory elements at addresses:
//   arr + 0, arr + 1, ..., arr + (size - 1).
func array_sum(arr: felt*, size) -> felt {
    if (size == 0) {
        return 0;
    }

    // size is not zero.
    let sum_of_rest = array_sum(arr=arr + 1, size=size - 1);
    return arr[0] + sum_of_rest;
}

func mul{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
    uint256_check(a);
    let (c: Uint256) = SafeUint256.add(a, b);
    return (c=c);
}

func div(a,b) -> felt {
    assert_not_zero(a);
    assert_not_zero(b);

    return 33;
}

func main{output_ptr: felt*}() {
    const ARRAY_SIZE = 4;

    let (ptr) = alloc();

    assert [ptr] = 9;
    assert [ptr + 1] = 16;
    assert [ptr + 2] = 25;
    assert [ptr + 3] = 10;

    let sum = array_sum(ptr, ARRAY_SIZE);
    serialize_word(sum);

    let d = div(10,3);
    serialize_word(d);

    return ();
}

