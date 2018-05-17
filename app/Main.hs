module Main where

import           Prelude             hiding (Either (..))
import           System.Console.ANSI
import           System.IO

import           Console
import           Level
import           Types

main = do
  hSetEcho stdin False
  hSetBuffering stdin  NoBuffering
  hSetBuffering stdout NoBuffering
  hideCursor
  setTitle "Thieflike"
  clearScreen
  let world = genesis { wLevel = level1, wLevels = [level1] }
  drawWorld world
  gameLoop world


gameLoop world = do
  drawHero world
  input <- getInput
  case input of
    Exit    -> handleExit
    Dir dir -> handleDir world dir


getInput = do
  char <- getChar
  case char of
    'q' -> return Exit
    'w' -> return (Dir Up)
    's' -> return (Dir Down)
    'a' -> return (Dir Left)
    'd' -> return (Dir Right)
    _   -> getInput


handleExit = do
  clearScreen
  setCursorPosition 0 0
  showCursor
  setSGR [Reset]
  putStrLn "Thank you for playing!"


dirToCoord Up    = (0, -1)
dirToCoord Down  = (0,  1)
dirToCoord Left  = (-1, 0)
dirToCoord Right = (1,  0)


handleDir w dir
  | isWall coord lvl ||
    isClosedDoor coord lvl = gameLoop w { wHero = h { hOldPos = hCurrPos h } }
  | otherwise              = gameLoop w { wHero = h { hOldPos  = hCurrPos h
                                                    , hCurrPos = coord } }
  where
    h              = wHero w
    lvl            = wLevel w
    coord          = (newX, newY)
    newX           = hConst heroX
    newY           = hConst heroY
    (heroX, heroY) = hCurrPos h |+| dirToCoord dir
    hConst i       = max 0 (min i 80)


-- same as before
(|+|) :: Coord -> Coord -> Coord
(|+|) (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)
