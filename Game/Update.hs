module Game.Update (updateAsteroids) where

import System.IO
import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Utils.IO
import Game.Data
import Data.List

updateAsteroids asteroidsRef ioBufRef = do
  newContents <- nbGetContents
  previousContents <- get ioBufRef
  let contents = previousContents ++ newContents
  let ls = lines contents
  
  unless (contents == []) $ putStrLn contents


availableLines :: String -> ([String], String)
availableLines "" = ([],"")
availableLines str = 
