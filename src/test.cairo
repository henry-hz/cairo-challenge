%lang starknet

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

const UNIT   = 100000;   // decimal precision
const GUESS  = 100000;   // first guess
const CYCLE  = 4;        // fixed cycles to run

func sqrt(n: felt, s: felt) -> (r: felt) {
    if (size == 0) {
        return 1;
    }

    let c = s - 1;
    let next = sqrt(s,c) + s/sqrt(s, c) / 2
    return next;
}


func main{output_ptr: felt*, range_check_ptr}() {
    serialize_word(3);
    return ();
}

