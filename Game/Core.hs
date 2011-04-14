module Game.Core (displayAsteroids,updateAsteroids) where

import Data.IORef

import Graphics.UI.GLUT

import Game.Data
import Game.Render
import Game.Update

displayAsteroids roidsRef = get roidsRef >>= mapM_ renderAsteroid


  -- renderPrimitive Points $ do
  --   color $ Color3 (0::GLfloat) 0 0
  --   vertex $ Vertex2 (0.8::GLfloat) 0.5




