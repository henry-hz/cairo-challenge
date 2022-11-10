




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


## Projects

* [ecosystem](https://www.starknet-ecosystem.com/en)
* [amm-zk](https://github.com/10k-swap/10k_swap-contracts)
* [maker-bridge](https://github.com/makerdao/starknet-dai-bridge)


## Issues


* Fixed known ap error using local:

```
cairo Only functions with known ap change may be used in an expression.
```
