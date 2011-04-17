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
  let usableContents = dropDiscardedLines contents
  
  unless (contents == []) $ putStrLn contents


dropDiscardedLines :: String -> String
dropDiscardedLines = foldl discardAfterTwoNewlines ""
  where discardAfterTwoNewlines str c =
    if (c == '\n' && not(null str) && c == last str)
      then ""
      else str ++ [c]

availableLines :: String -> ([String], String)
availableLines "" = ([],"")
availableLines str = 
