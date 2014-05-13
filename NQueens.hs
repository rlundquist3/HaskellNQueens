-- Riley Lundquist
-- Principles of Programming Languages
-- April 2014

-- NQueens Problem
-- This is a functional programming solution to the N Queens Problem. The
-- NQueens module contains the functions necessary to check and place
-- queens on a board from the Board module.
--
-- To find a solution for a board of size n, call
--	nQueens n
-- If a solution exists, a "board" will be returned with True indicating
-- the locations of queens and False indicating empty spaces. Otherwise,
-- an empty list will be returned. 

module NQueens where
import Board
import TestSuiteSupportModule

-- Checks if the specified space is "safe" (a queen can be placed there) on the passed board
safe :: [[Bool]] -> [Int] -> Bool
safe board index = not ((True `elem` row) || (True `elem` col) || (True `elem` leftDiag) || (True `elem` rightDiag))
	where
		col = getCol board (fromIntegral (index !! 1))
                row = getRow board (fromIntegral (index !! 0))
		leftDiag = getLeftDiag board index
		rightDiag = getRightDiag board index

safeTestSuite = TestSuite "Test safe"
	[
		Test "Unsafe in row" (safe [[True,False,False],[False,False,False],[False,False,False]] [0,1] == False),
		Test "Unsafe in colunn" (safe [[True,False,False],[False,False,False],[False,False,False]] [1,0] == False),
		Test "Unsafe in diag" (safe [[True,False,False],[False,False,False],[False,False,False]] [1,1] == False),
		Test "Safe on empty board" (safe [[False,False,False],[False,False,False],[False,False,False]] [0,0] == True),
		Test "Safe when others present" (safe [[True,False,False],[False,False,False],[False,False,False]] [1,2] == True)
	]

-- Creates a new row to represent a newly placed queen (helper function for setSpace)
setRow :: Int -> Int -> [Bool]
setRow size col = replicate (col) False ++ [True] ++ replicate (size - col - 1) False

setRowTestSuite = TestSuite "Test setRow"
	[
		Test "First space" (setRow 3 0 == [True,False,False]),
		Test "Interior space" (setRow 3 1 == [False,True,False]),
		Test "Last space" (setRow 3 2 == [False,False,True])
	]

-- Sets the specified space on the board to True to represent the newly placed queen if it is safe
setSpace :: [[Bool]] -> [Int] -> [[Bool]]
setSpace board index
	| safe board index = take rowIndex board ++ [setRow (length board) colIndex] ++ drop (rowIndex + 1) board
	| otherwise = error "Unsafe placement"
	where
		rowIndex = fromIntegral (index !! 0)
		colIndex = fromIntegral (index !! 1)

setSpaceTestSuite = TestSuite "Test setSpace"
	[
		Test "First space" (setSpace [[False,False,False],[False,False,False],[False,False,False]] [0,0] == [[True,False,False],[False,False,False],[False,False,False]]),
		Test "Interior space" (setSpace [[False,False,False],[False,False,False],[False,False,False]] [1,1] == [[False,False,False],[False,True,False],[False,False,False]]),
		Test "Last space" (setSpace [[False,False,False],[False,False,False],[False,False,False]] [2,2] == [[False,False,False],[False,False,False],[False,False,True]])
	]

-- Recursively places queens on the passed board beginning with the specified space. Returns an empty list if no solution is found.
placeQueen :: [[Bool]] -> [Int] -> [[Bool]]
placeQueen board index
	| rowIndex == length board = board
	| colIndex == length board = []
	| safe board index && placeQueen (setSpace board index) [rowIndex+1,0] == [] = placeQueen board [rowIndex,colIndex+1]
	| safe board index =  placeQueen (setSpace board index) [rowIndex+1,0]
	| otherwise = placeQueen board [rowIndex,colIndex+1]
	where
		rowIndex = fromIntegral (index !! 0)
		colIndex = fromIntegral (index !! 1)

-- Creates a board of indicated size and attempts to find a solution
nQueens :: Int -> [[Bool]]
nQueens size = placeQueen (makeBoard size) [0,0]
