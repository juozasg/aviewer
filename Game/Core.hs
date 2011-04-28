module Game.Core (displayAsteroids,updateAsteroids) where

import Data.IORef

import Graphics.UI.GLUT

import Game.Data
import Game.Render
import Game.Update

displayAsteroids roidsRef = get roidsRef >>= mapM_ renderAsteroid

