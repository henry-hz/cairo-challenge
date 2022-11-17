# Challenge

Write a sqrt algorithm in cairo using with $10^{18}$ [fixed-point-aritmetic](https://en.wikipedia.org/wiki/Fixed-point_arithmetic)




## Install Cairo


* [setup-environment](https://www.cairo-lang.org/docs/quickstart.html#)

- on debian, add [python-dev]
```
sudo apt-get install python3-dev
```


## Setup

Add an out folder and load env vars. Edit the setup.sh file with the paths of your home dir.

```
# output dir
mkdir out

# setup
. ./setup.sh
```

## Develop

```
FILE=test make watch
```

## Run

```
FILE=test make compile && FILE=test make run
```

## Resources


* [cairo-goldmine](https://github.com/beautyisourbusiness/cairo-goldmine)
* [vim-cairo-gist](https://gist.github.com/amanusk/f73dee988829110ad557c8cba89e4652)
* [starknet-compile](https://www.cairo-lang.org/docs/hello_starknet/intro.html)
* [cairo-intro](https://chainstack.com/starknet-cairo-developer-introduction-part-2/)
* [uint256-felt](https://mirror.xyz/0x845605C411132BAA06024a521a85B653F3C802dF/wfUO8KSz2IAt8yg4oslsc1HDsJqMJ6HpQAukhjwZUUU)
* [type-safety](https://ctrlc03.github.io/#type-safety)
* [uint256-example](https://medium.com/starkware/cairo-1-0-aa96eefb19a0)
* [learn-notes](https://hackmd.io/@RoboTeddy/BJZFu56wF)
* [fixed-point-lib](https://github.com/influenceth/cairo-math-64x61/blob/master/contracts/cairo_math_64x61/math64x61.cairo)
* [safe-math](https://github.com/NethermindEth/Cairo-SafeMath)
* [floating-point-in-solidity](https://levelup.gitconnected.com/simulating-floating-point-division-in-solidity-35b56d2b597e)
* [512-bit-divition](https://medium.com/wicketh/mathemagic-512-bit-division-in-solidity-afa55870a65)
* [256-bit-computing](https://www.wikiwand.com/en/256-bit_computing)
* [1-million-digits](https://apod.nasa.gov/htmltest/gifcity/sqrt2.1mil)
* [512-full-multiply](https://medium.com/wicketh/mathemagic-full-multiply-27650fec525d)
* [long-multiplication](https://en.wikipedia.org/wiki/Multiplication_algorithm#Long_multiplication)
* [felt-explained](https://www.youtube.com/watch?v=jcrAq71WwSM)
* [top-9-math](https://typefully.com/Starknet_Intern/aVMUp7A)



## Projects

* [ecosystem](https://www.starknet-ecosystem.com/en)
* [amm-zk](https://github.com/10k-swap/10k_swap-contracts)
* [maker-bridge](https://github.com/makerdao/starknet-dai-bridge)


## Issues


* Fixed known ap error using local:

```
cairo Only functions with known ap change may be used in an expression.
```



## Draft

```
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

```
340282366920938463463374607431768211456 - 2**128 [39 digits]
141421356237309504880168872420969807857 - my solution [39 digits], looping 10 cycles
14142135623730950488016887242096980785696718753769480731766797379907324784621 - [77 digits]



