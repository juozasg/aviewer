module Game.Update (updateAsteroids) where

import System.IO
import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Utils.IO
import Game.Data
import Data.List

updateAsteroids asteroidsRef stdioBufRef steps = do
  previousContents <- get stdioBufRef
  newContents <- nbGetContents
  let allContents = previousContents ++ newContents
  let (newAsteroids, remainingContent, clear) = parseAsteroidsInput allContents

  previousWorldAsteroids <- if clear then return noWorldAsteroids else get asteroidsRef

  newWorldAsteroids <- mapM randomlyAddAsteroidToWorld newAsteroids

  asteroidsRef $= map (stepWorldAsteroid steps) (previousWorldAsteroids ++ newWorldAsteroids)
  stdioBufRef $= remainingContent

parseAsteroidsInput :: String -> (Asteroids, String, Bool)
parseAsteroidsInput str =
  let cutIndeces = elemIndices 'x' str
      clear = length cutIndeces > 0
      (_, goodStr) = splitAt (last $ 0:cutIndeces) str
      (asteroids, remainder) = parseAsteroids goodStr
  in  (asteroids, remainder, clear)

parseAsteroids :: String -> (Asteroids, String)
parseAsteroids "" = (noAsteroids, "")
parseAsteroids str =
  let (parsableLines, reminder) =
        if last str == '\n'
          then (lines str, "")
          else (init $ lines str, last $ lines str)
  in  (map parseAsteroid parsableLines, reminder)

parseAsteroid :: String -> Asteroid
parseAsteroid str =
  case reads str :: [(Asteroid, String)] of
    [] -> []
    (asteroid, _):_ -> asteroid

