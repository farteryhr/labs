# labs

misc things, brain holes, etc.

straightforward yet shitty code.

mostly runnable on a normal pc within some minutes requiring reasonably large RAM.

## 123456789.cpp

bruteforce enumeration of Crazy Sequential Representation.

based on expression tree building and memorized subproblem.

supports +-×÷, brackets, power(^), concatenation. features floating point fixing and some pruning.

[Inder J. Taneja's paper](https://arxiv.org/abs/1302.1479)

[Numberphile's youtube video: the 10958 problem](https://www.youtube.com/watch?v=-ruC5A9EzzE)

needs 2gb ram for the full size problem.

## bejeweled.c

how many fields **exactly** are there are stable in the game [Bejeweled](http://www.bejeweled.com/) (or its ancestor, [shariki](https://en.wikipedia.org/wiki/Shariki))?

8×8, 7 colors, stable means no 3 gems of the same color in a row/column.

the answer given is 203601887802130611210536633992503090012487776690503574 which matches the number estimated by generating random fields.

based on essential pattern and some combinatorics, also Chinese remainder theory.

but still no idea for **"no more moves"**.

needs 5gb ram on the full size problem, you have to use 64-bit compilation.

## god2048.cpp

bruteforce enumeration of **3×3** simplified 2048 game tree. (giving only "2" on a random position each turn)

based on expecti-max. the result is you can always get a constant max score.

after computation, you enter a simple inspector.

but still no idea for **4×4**.

needs 2×10^9 bytes ram.

## cm.g4

parser of mathematic expressions in Chinese language as close to usually spoken.

the hardest part turns out to be the structure of how a single (big) number is read in chinese.

## sudoku.c

yet another fast and simple sudoku solver. supports both pure naive top-down order and least-candidate-first strategy (switch via `#define`).

with full usage of bitwise operations, balancing number of operations and data footprint, it's able to run 2.5G recursions (naive version) per minute on my laptop (i3 M350 2.27Hz, GCC 4.7.2).

try to crack them, prove whether they have no, unique or multiple solutions.
```
4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......
..............3.85..1.2.......5.7.....4...1...9.......5......73..2.1........4...9
.....5.8....6.1.43..........1.5........1.6...3.......553.....61........4.........
```
see my [stackoverflow quesion](https://stackoverflow.com/questions/24682039).

## t-ex_core.as

core (means pretty much everything) code of flash version of t-ex (available at farter.cn homepage) which is almost direct translation of vb6 version.

old code, old flavor. not uglified/minified by any tool. but it's decompiled from my releases because i lost the source. since it mostly uses global variable, the code is readable.

for example, `kpmr`/`kcmr` means "Key isPressed/frameCounter of Move Right".
