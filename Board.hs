-- Riley Lundquist
-- Principles of Programming Languages
-- April 2014

-- NQueens Problem
-- The Board module implements all necessary board functions for solving
-- the N Queens problem. The TestSuiteSupportModule is used for testing
-- these functions.

module Board where
import TestSuiteSupportModule

-- Makes a "row" (list) of indicated size of False values
makeRow :: Int -> [Bool]
makeRow n = replicate n False

makeRowTestSuite = TestSuite "Test makeRow"
    [
        Test "0" (makeRow 0 == []),
        Test "3" (makeRow 3 == [False,False,False])
    ]

-- Makes a square "board" (list of lists) of indicated size of False values
makeBoard :: Int -> [[Bool]]
makeBoard n = replicate n (makeRow n)

makeBoardTestSuite = TestSuite "Test makeBoard"
    [
        Test "0" (makeBoard 0 == []),
        Test "3" (makeBoard 3 == [[False,False,False],[False,False,False],[False,False,False]])
    ]

-- Gets the specified row from passed board (indices 0 - length-1)
getRow :: [[Bool]] -> Int -> [Bool]
getRow board n = board !! n

getRowTestSuite = TestSuite "Test getRow"
    [
        Test "First row" (getRow [[True,True,True],[False,False,False],[False,False,False]] 0 == [True,True,True]),
        Test "Last row" (getRow [[False,False,False],[False,False,False],[True,True,True]] 2 == [True,True,True])
    ]

-- Gets the specified column from passed board (indices 0 - length-1)
getCol :: [[Bool]] -> Int -> [Bool]
getCol board n = map (!! n) board

getColTestSuite = TestSuite "Test getCol"
    [
        Test "First column" (getCol [[True,False,False],[True,False,False],[True,False,False]] 0 == [True,True,True]),
        Test "Last column" (getCol [[False,False,True],[False,False,True],[False,False,True]] 2 == [True,True,True])
    ]

-- Gets the specified space from passed board (indices [0,0] - [length-1,length-1])
getSpace :: [[Bool]] -> [Int] -> Bool
getSpace board index = board !! fromIntegral (index !! 0) !! fromIntegral (index !! 1)

getSpaceTestSuite = TestSuite "Test getSpace"
    [
        Test "First space" (getSpace [[True,False,False],[False,False,False],[False,False,False]] [0,0] == True),
        Test "Last space" (getSpace [[False,False,False],[False,False,False],[False,False,True]] [2,2] == True)
    ]

-- Gets the bottom left to top right diagonal containing the specified space from the passed board
getLeftDiag :: [[Bool]] -> [Int] -> [Bool]
getLeftDiag board index = [getSpace board [x,y] | x <- [0..length board - 1], y <- [0..length board - 1], x+y == (index !! 0) + (index !! 1)]

getLeftDiagTestSuite = TestSuite "Test getLeftDiag"
    [
        Test "Top left space" (getLeftDiag [[True,False,False],[False,False,False],[False,False,False]] [0,0] == [True]),
        Test "Middle space" (getLeftDiag [[False,False,True],[False,True,False],[True,False,False]] [1,1] == [True,True,True]),
        Test "Bottom left space" (getLeftDiag [[False,False,True],[False,True,False],[True,False,False]] [2,0] == [True,True,True])
    ]

-- Gets the bottom right to top left diagonal containing the specified space from the passed board
getRightDiag :: [[Bool]] -> [Int] -> [Bool]
getRightDiag board index = [getSpace board [x,y] | x <- [0..length board - 1], y <- [0..length board - 1], x-y == (index !! 0) - (index !! 1)]

getRightDiagTestSuite = TestSuite "Test getRightDiag"
    [
        Test "Top left space" (getRightDiag [[True,False,False],[False,True,False],[False,False,True]] [0,0] == [True,True,True]),
        Test "Middle space" (getRightDiag [[True,False,False],[False,True,False],[False,False,True]] [1,1] == [True,True,True]),
        Test "Bottom left space" (getRightDiag [[False,False,False],[False,False,False],[True,False,False]] [2,0] == [True])
    ]
