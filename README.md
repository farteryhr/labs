# labs

misc things, brain holes, etc.

straightforward yet shitty code.

mostly runnable on a normal pc within some minutes requiring reasonably large RAM.

## 123456789.cpp

bruteforce enumeration of Crazy Sequential Representation.

based on expression tree building and memorized subproblem.

supports +-×÷, brackets, power(^), concatenation. features floating point fixing and some pruning.

[Inder J. Taneja's paper][https://arxiv.org/abs/1302.1479]

[Numberphile's youtube video: the 10958 problem][https://www.youtube.com/watch?v=-ruC5A9EzzE]

needs 2gb ram for the full size problem.

## bejeweled.c

how many fields **exactly** are there are stable in the game [Bejeweled][http://www.bejeweled.com/]?

8×8, 7 colors, no 3 gems of the same color in a row.

based on essential pattern and some combinatorics, also Chinese remainder theory.

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
