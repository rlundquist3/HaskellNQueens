HaskellNQueens
==============

Riley Lundquist

April 2014

An implemenation of the NQueens problem in Haskell.

Running the Program:
--------------------

You must have GHC or hugs installed to run HaskellNQueens.

```
$ ghci NQueens.hs
```
Should result in output similar to:
```
GHCi, version 7.6.3: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
[1 of 3] Compiling TestSuiteSupportModule ( TestSuiteSupportModule.hs, interpreted )
[2 of 3] Compiling Board            ( Board.hs, interpreted )
[3 of 3] Compiling NQueens          ( NQueens.hs, interpreted )
Ok, modules loaded: NQueens, Board, TestSuiteSupportModule.
```
Pass the nQueens function the board size to check for a solution. The program will output a list of lists of Boolean values to represent the rows of the board after solving (True represents a queen, False represents an empty space). If there is no solution, [] will be printed.
```
*NQueens> nQueens 3
[]
*NQueens> nQueens 5
[[True,False,False,False,False],[False,False,True,False,False],[False,False,False,False,True],[False,True,False,False,False],[False,False,False,True,False]]
*NQueens> nQueens 12
[[True,False,False,False,False,False,False,False,False,False,False,False],[False,False,True,False,False,False,False,False,False,False,False,False],[False,False,False,False,True,False,False,False,False,False,False,False],[False,False,False,False,False,False,False,True,False,False,False,False],[False,False,False,False,False,False,False,False,False,True,False,False],[False,False,False,False,False,False,False,False,False,False,False,True],[False,False,False,False,False,True,False,False,False,False,False,False],[False,False,False,False,False,False,False,False,False,False,True,False],[False,True,False,False,False,False,False,False,False,False,False,False],[False,False,False,False,False,False,True,False,False,False,False,False],[False,False,False,False,False,False,False,False,True,False,False,False],[False,False,False,True,False,False,False,False,False,False,False,False]]
```
