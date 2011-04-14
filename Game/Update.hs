module Game.Update (updateAsteroids) where

import System.IO
import Control.Monad

import qualified Data.ByteString as B


import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data

updateAsteroids asteroidsRef = do
  -- asteroids <- get asteroidsRef
  -- available <- hReady stdin
  text <- B.hGetNonBlocking stdin 1
  B.hPutStr stdout text
  hFlush stdout
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
