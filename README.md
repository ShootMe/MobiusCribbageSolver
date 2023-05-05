# Mobius Front 83 Cribbage Solitaire Solver
Calculates the optimal solution to a deal in the game by Zachtronics

## Running
  - Compile and pass in the deal to be solved
  - ex) .exe 75AQJ9Q5723Q9_22K5A288KTKJT_7J5TAAK6884J6_T64399Q734643
  - Will output the best score and steps to achieve
  - ex) Best Score: 110 Steps: 122_122_11222_2244231_3333_414443_141_2244_1131_32441413_334_33 Took: 00:00:01.1040290

## Deal Format
  - Pile1_Pil2_Pile3_Pile4
  - Piles are listed from top to bottom with one character per card rank
  - Ranks are the following: A 2 3 4 5 6 7 8 9 T J Q K

## Solution
  - A list of piles to click
  - In the above example, 122_ , means the first stack is pile 1, pile 2, pile 2
  
## Stats
  - Fastest deal in the first 120 deals of the game is #95 taking about 0.3s
  - Slowest deal in the first 120 deals of the game is #110 taking about 2.0s
  - Average solve time is about 0.8s
  - Lowest score in the first 120 deals is 81 in game #57
  - Highest score in the first 120 deals is 118 in game #70 and #72
  - Lowest score found from just random deals is 76 for deal T64K493TA553A_Q672QA6A95K5T_8Q7K8Q89J2792_3JT4J84J26K73
  - Highest score found from just random deals is 140 for deal J99A7926A4A65_QQ79KA3KK8823_Q523TTJ54K82T_8J64Q7T7563J4