module Level where

import qualified Data.Map as M

import           Types


strsToLevel :: [String] -> Level
strsToLevel str = foldl populate emptyLevel {lMax=maxXY} asciiMap
  where
    asciiMap = concat $ zipWith zip coords str
    coords   = [[(x, y) | x <- [0..]] | y <- [0..]]
    maxX     = maximum . map (fst . fst) $ asciiMap
    maxY     = maximum . map (snd . fst) $ asciiMap
    maxXY    = (maxX, maxY)
    populate lvl (coord, tile) =
      case tile of
        '#' -> lvl { lTiles = M.insert coord Wall            t }
        '>' -> lvl { lTiles = M.insert coord (St Downstairs) t }
        '<' -> lvl { lTiles = M.insert coord (St Upstairs)   t }
        '+' -> lvl { lTiles = M.insert coord (Dr Closed)     t }
        '-' -> lvl { lTiles = M.insert coord (Dr Open)       t }
        '~' -> lvl { lTiles = M.insert coord Acid            t }
        _   -> lvl
        where t = lTiles lvl


isAcid coord lvl = case M.lookup coord (lTiles lvl) of
  Just Acid -> True
  _         -> False


isClosedDoor coord lvl = case M.lookup coord (lTiles lvl) of
  Just (Dr Closed) -> True
  _                -> False


isOpenDoor coord lvl = case M.lookup coord (lTiles lvl) of
  Just (Dr Open) -> True
  _              -> False


isWall coord lvl = case M.lookup coord (lTiles lvl) of
  Just Wall -> True
  _         -> False


isDownstairs coord lvl = case M.lookup coord (lTiles lvl) of
  Just (St Downstairs) -> True
  _                    -> False


isUpstairs coord lvl = case M.lookup coord (lTiles lvl) of
  Just (St Upstairs) -> True
  _                  -> False


isGold coord lvl = M.member coord (lGold lvl)


isVillain coord lvl = M.member coord (lVillains lvl)


isArmor coord lvl = case M.lookup coord (lItems lvl) of
  Just (Arm _) -> True
  _            -> False


isPotion coord lvl = case M.lookup coord (lItems lvl) of
  Just (Pot _) -> True
  _            -> False


isWeapon coord lvl = case M.lookup coord (lItems lvl) of
  Just (Weap _) -> True
  _             -> False


map1   = [ "##############"
         , "#>           #          ######"
         , "#            ############    #"
         , "#            -          +    #"
         , "#    ~~      ############    #"
         , "#     ~~     #          #    #"
         , "#      ~~    #          # <  #"
         , "##############          ######" ]


level1 = strsToLevel map1
