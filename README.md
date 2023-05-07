# Mobius Front 83 Cribbage Solitaire Solver
Calculates the optimal solution to a deal in the game by Zachtronics

## Running
  - Compile and pass in the deal to be solved
  - ex) .exe 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643
  - or pass in the deal number (can be a number beyond the 2000 in the game)
  - ex) .exe 1
  - Will output the best score and steps to achieve
  - ex) Deal: 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643 Score: 110 Steps: 122_122_11222_2244231_3333_414443_141_2244_1131_32441413_334_33 Took: 00:00:01.1040290

## Deal Format
  - Pile1_Pil2_Pile3_Pile4
  - Piles are listed from top to bottom with one character per card rank
  - Ranks are the following: A 2 3 4 5 6 7 8 9 T J Q K

## Solution
  - A list of piles to click
  - In the above example, 122_ , means the first stack is pile 1, pile 2, pile 2
  
## Stats
  - Game has 2000 total deals
  - Fastest deal is #1479 taking about 0.2s
  - Slowest deal is #1879 taking about 3.9s
  - Took 1704s (28m 24s) to solve all 2000 deals
  - Average solve time is about 0.85s
  - Lowest score is 80 in deal #1031
  - Highest score is 126 in deal #969
 
 ## Extra Stats
  - Going beyond and solving the first million deals
  - Fastest deal is #776597 taking about 0.16s
  - Slowest deal is #358167 taking about 6.86s
  - Took 863788s (9d 23h 56m 28s) to solve all 1000000 deals
  - Average solve time is about 0.86s
  - Lowest score is 75 in deal #184485
  - Highest score is 141 in deal #612524
  - Average score is 101. Most occuring score is 100, with 58513 out of the 1000000.