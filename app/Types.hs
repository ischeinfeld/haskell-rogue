--file: Types.hs
module Types where

import qualified Data.Map as M

type Coord = (Int, Int)

-- foul beasts
data Villain = Villain { vCurrPos :: Coord
                       , vGold    :: Int
                       , vHP      :: Int
                       , vItems   :: [Item]
                       , vOldPos  :: Coord }

data Item = Arm Armor
          | Pot Potion
          | Weap Weapon

data Armor = Armor { aDefense :: Int
                   , aDest    :: String }

data Potion = Potion { pAmount :: Int
                     , pDesc   :: String
                     , pEffect :: Effect }

data Effect = Harm
            | Heal

data Weapon = Weapon { wDamage :: Int
                     , wDesc   :: String
                     , wToHit  :: Int }

data Tile = Acid
          | Dr   Door
          | St   Stairs
          | Wall

data Door = Closed
          | Open

data Stairs = Downstairs
            | Upstairs

data Input = Dir Direction
           | Exit

data Direction = Up
               | Down
               | Left
               | Right

data Hero = Hero { hCurrPos :: Coord
                 , hGold    :: Int
                 , hHP      :: Int
                 , hItems   :: [Item]
                 , hOldPos  :: Coord
                 , hWield   :: Weapon
                 , hWears   :: Armor  }

data Level = Level { lDepth    :: Int
                   , lGold     :: M.Map Coord Int
                   , lItems    :: M.Map Coord Item
                   , lMapped   :: M.Map Coord Bool
                   , lMax      :: Coord
                   , lTiles    :: M.Map Coord Tile
                   , lVillains :: M.Map Coord Villain }

data World = World { wDepth  :: Int
                   , wHero   :: Hero
                   , wLevel  :: Level
                   , wLevels :: [Level] }
