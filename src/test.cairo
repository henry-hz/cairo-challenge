%lang starknet

from starkware.cairo.common.serialize import serialize_word

// sqrt 0 s = 1
// sqrt n s = (x + s/x) / 2 where x = sqrt (n-1) s

const UNIT   = 100000;   // decimal precision
const GUESS  = 100000;   // first guess
const CYCLE  = 4;        // fixed cycles to run

func fibo(n : felt) -> (result : felt) {
  alloc_locals;
  if (n == 0) {
    return (result=0);
  }
  if (n == 1) {
    return (result=1);
  }
  let (local x) = fibo(n - 1);
  let (local y) = fibo(n - 2);
  return (result = x + y);
}

func sqrt(n: felt, s: felt) -> felt {
    if (n == 0) {
        return 1;
    }

    let c = n - 1;
    //let next = sqrt(s,c) / 2;
    let next = 3;
    return next;
}

func array_sum(arr: felt*, size) -> felt {
    if (size == 0) {
        return 0;
    }

    // size is not zero.
    let sum_of_rest = array_sum(arr=arr + 1, size=size - 1);
    return arr[0] + sum_of_rest;
}


func main{output_ptr: felt*, range_check_ptr}() {
    let x = fibo(3);
    serialize_word(x);
    return ();
}

