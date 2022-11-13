%builtins output range_check

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

from starkware.cairo.common.math import unsigned_div_rem

const STEPS = 50;
const WAD   = 10**18;

func mul{range_check_ptr}(x, y) -> felt {
    alloc_locals;
    let z1 = x * WAD;
    let (z2,_) = unsigned_div_rem(y,2);
    let z3 = z1 + z2;
    let (z4,_) = unsigned_div_rem(z3, WAD);
    return z4;
}

// z = add(mul(x, WAD), y / 2) / y;
func div{range_check_ptr}(x,y) -> felt {
    alloc_locals;
    let z1 = x * WAD;
    let (z2,_) = unsigned_div_rem(y, 2);
    let z3 = z1 + z2;
    let (z4,_) = unsigned_div_rem(z3,y);
    return z4;
}

func sqrt{range_check_ptr}(n: felt, s: felt) -> (result: felt) {
    alloc_locals;
    if (n == 0) {
        return (result = WAD);
    }
    let (local x) = sqrt(n - 1, s);
    let q1 = div(s, x);
    let q2 = div((x + q1), 2 * WAD);
    return (result = q2);
}

func main{output_ptr: felt*, range_check_ptr}() {
    // test division
    let r1 = div(10500000000000000000, 1050000000000000000);
    assert r1 = 10*WAD;

    // high precision
    let (y1) = sqrt(STEPS, 2*WAD);
    assert y1 = 1414213562373095049;
    return ();
}


