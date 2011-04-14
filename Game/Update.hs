module Game.Update (updateAsteroids) where

import System.IO
import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data

updateAsteroids asteroidsRef = do
  return ()
  -- asteroids <- get asteroidsRef
  -- available <- hReady stdin
  -- if available == True
  --  then do 
  --    putStrLn $ show available
  --    (liftM (\x -> [x]) getChar) >>= putStrLn
  --  else return ()




    -- $ show available 
      --getChar >>= putStrLn  
  -- return ()
  -- asteroidStr <- getLine
  -- return ()
  -- if asteroidStr == ""
  --  asteroidsRef $= noAsteroids
