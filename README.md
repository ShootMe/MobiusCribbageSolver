# Mobius Front 83 Cribbage Solitaire Solver
Calculates the optimal solution to a deal in the game by Zachtronics

## Running
  - Compile and pass in the deal to be solved
  - ex) .exe 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643
  - Will output the best score and steps to achieve
  - ex) Best Score: 110 Steps: 122_122_11222_2244231_3333_414443_141_2244_1131_32441413_334_33 Took: 00:00:01.1040290

## Deal Format
  - [Pile1]_[Pil2]_[Pile3]_[Pile4]
  - Piles are listed from top to bottom with one character per card rank
  - Ranks are the following: A 2 3 4 5 6 7 8 9 T J Q K

## Solution
  - A list of piles to click
  - In the above example, 122_ , means the first stack is pile 1, pile 2, pile 2