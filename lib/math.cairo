

from starkware.cairo.common.math import assert_nn_le, unsigned_div_rem
from starkware.cairo.common.cairo_builtins import HashBuiltin
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
namespace SafeUint256 {
    const WAD   = 10 ** 30;
    const SHIFT = 2 ** 128;
    // Adds two integers.
    // Reverts if the sum overflows.
    func add{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
        uint256_check(a);
        uint256_check(b);
        let (c: Uint256, is_overflow) = uint256_add(a, b);
        with_attr error_message("SafeUint256: addition overflow") {
            assert is_overflow = FALSE;
        }
        return (c=c);
    }

    // Subtracts two integers.
    // Reverts if subtrahend (`b`) is greater than minuend (`a`).
    func sub_le{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
        alloc_locals;
        uint256_check(a);
        uint256_check(b);
        let (is_le) = uint256_le(b, a);
        with_attr error_message("SafeUint256: subtraction overflow") {
            assert is_le = TRUE;
        }
        let (c: Uint256) = uint256_sub(a, b);
        return (c=c);
    }

    // Subtracts two integers.
    // Reverts if subtrahend (`b`) is greater than or equal to minuend (`a`).
    func sub_lt{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
        alloc_locals;
        uint256_check(a);
        uint256_check(b);

        let (is_lt) = uint256_lt(b, a);
        with_attr error_message("SafeUint256: subtraction overflow or the difference equals zero") {
            assert is_lt = TRUE;
        }
        let (c: Uint256) = uint256_sub(a, b);
        return (c=c);
    }

    // Multiplies two integers.
    // Reverts if product is greater than 2^256.
    func mul{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256) {
        alloc_locals;
        uint256_check(a);
        uint256_check(b);
        let (a_zero) = uint256_eq(a, Uint256(0, 0));
        if (a_zero == TRUE) {
            return (c=a);
        }

        let (b_zero) = uint256_eq(b, Uint256(0, 0));
        if (b_zero == TRUE) {
            return (c=b);
        }

        let (c: Uint256, overflow: Uint256) = uint256_mul(a, b);
        with_attr error_message("SafeUint256: multiplication overflow") {
            assert overflow = Uint256(0, 0);
        }
        return (c=c);
    }

    // Integer division of two numbers. Returns uint256 quotient and remainder.
    // Reverts if divisor is zero as per OpenZeppelin's Solidity implementation.
    // Cairo's `uint256_unsigned_div_rem` already checks:
    //    remainder < divisor
    //    quotient * divisor + remainder == dividend
    func div_rem{range_check_ptr}(a: Uint256, b: Uint256) -> (c: Uint256, rem: Uint256) {
        alloc_locals;
        uint256_check(a);
        uint256_check(b);

        let (is_zero) = uint256_eq(b, Uint256(0, 0));
        with_attr error_message("SafeUint256: divisor cannot be zero") {
            assert is_zero = FALSE;
        }

        let (c: Uint256, rem: Uint256) = uint256_unsigned_div_rem(a, b);
        return (c=c, rem=rem);
    }

    func wmul{range_check_ptr}(lhs : Uint256, rhs : Uint256) -> (res : Uint256) {
        alloc_locals;
        if (rhs.high == 0) {
            if (rhs.low == 0) {
                with_attr error_message("Division by zero error") {
                    assert 1 = 0;
                }
            }
        }
        // z = add(mul(x, y), WAD / 2) / WAD;
        let (z1: Uint256) = mul(lhs, rhs);
        let (z2: Uint256) = warp_div256(Uint256(WAD,0), Uint256(2,0));
        let (z3: Uint256) = add(z1,z2);
        let (z4: Uint256) = warp_div256(z3, Uint256(WAD,0));
        return (res = z4);
    }

    func wdiv{range_check_ptr}(lhs : Uint256, rhs : Uint256) -> (res : Uint256) {
        alloc_locals;
        if (rhs.high == 0) {
            if (rhs.low == 0) {
                with_attr error_message("Division by zero error") {
                    assert 1 = 0;
                }
            }
        }
        // z = add(mul(x, WAD), y / 2) / y;
        let (z1: Uint256) = mul(lhs, Uint256(WAD,0));
        let (z2: Uint256) = warp_div256(rhs, Uint256(2,0));
        let (z3: Uint256) = add(z1, z2);
        let (z4: Uint256) = warp_div256(z3, rhs);
        return (res = z4);
    }

    func wmul2{range_check_ptr}(x, y) -> felt {
        alloc_locals;
        let z1 = x * WAD;
        let (z2,_) = unsigned_div_rem(y,2);
        let z3 = z1 + z2;
        let (z4,_) = unsigned_div_rem(z3, WAD);
        return z4;
    }

    func wdiv2{range_check_ptr}(x,y) -> felt {
        alloc_locals;
        let z1 = x * WAD;
        let (z2,_) = unsigned_div_rem(y, 2);
        let z3 = z1 + z2;
        let (z4,_) = unsigned_div_rem(z3,y);
        return z4;
    }

    func warp_div256{range_check_ptr}(lhs : Uint256, rhs : Uint256) -> (res : Uint256) {
        if (rhs.high == 0) {
            if (rhs.low == 0) {
                with_attr error_message("Division by zero error") {
                    assert 1 = 0;
                }
            }
        }
        let (res : Uint256, _) = uint256_unsigned_div_rem(lhs, rhs);
        return (res = res);
    }
}
