%builtins output

from starkware.cairo.common.serialize import serialize_word
from starkware.cairo.common.alloc import alloc


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

func main{output_ptr: felt*}() {
    const ARRAY_SIZE = 4;

    let (ptr) = alloc();

    assert [ptr] = 9;
    assert [ptr + 1] = 16;
    assert [ptr + 2] = 25;
    assert [ptr + 3] = 10;

    let sum = array_sum(ptr, ARRAY_SIZE);
    serialize_word(sum);

    return ();
}
