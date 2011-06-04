module Game.Data.Asteroid where

import System.Random
import Control.Applicative

import Data.List

import Utils.IO


type Position = (Float, Float)
type Velocity = (Float, Float)

worldHeight = 1.0 :: Float
worldWidth = 1.6 :: Float

worldYCenter = worldHeight / 2
worldXCenter = worldWidth / 2


type Asteroid = [Position]
type Asteroids = [Asteroid]
noAsteroids = [] :: Asteroids

type WorldAsteroid = (Asteroid, Position, Velocity)
type WorldAsteroids = [WorldAsteroid]

noWorldAsteroids = [] :: WorldAsteroids


randomlyAddAsteroidToWorld :: Asteroid -> IO WorldAsteroid
randomlyAddAsteroidToWorld a = do
  p <- randomPosition
  v <- randomVelocity

  putStrLn $ "Added: " ++ show (a,p,v)
  return (a, p, v)


randomPosition :: IO Position
-- randomPosition = return (0.8,0.5)
randomPosition = (,) <$> randomRIO (0,1.6) <*> randomRIO (0,1)

randomVelocity :: IO Velocity
-- randomVelocity = return (0.00025,-0.0005)
randomVelocity = (,) <$> randomRIO (0,0.001) <*> randomRIO (0,0.001)


worldAsteroidToScreen :: WorldAsteroid -> Asteroid
worldAsteroidToScreen (as, (px, py), _) = map (\(x,y) -> (x+px,y+py)) as

stepWorldAsteroid ::Int -> WorldAsteroid -> WorldAsteroid
stepWorldAsteroid steps (as, (px, py), v@(vx, vy)) = wrapWorldAsteroid (as, (px + vx*s, py + vy*s), v)
  where s = fromIntegral steps


wrapWorldAsteroid :: WorldAsteroid -> WorldAsteroid
wrapWorldAsteroid wa@(as, (px,py),v) =
  let (dx,dy) = offsetBy minX maxX minY maxY
  in  (as, (px+dx,py+dy),v)
  where
    xs = map fst $ worldAsteroidToScreen wa
    ys = map snd $ worldAsteroidToScreen wa
    minX = minimum xs
    maxX = maximum xs
    minY = minimum ys
    maxY = maximum ys
    centerX = px
    centerY = py
    invertXDisplacement = (worldXCenter-centerX) * 2
    offsetBy minX maxX minY maxY
      | minX > worldWidth   = (-maxX, 0)
      | maxX < 0            = (worldWidth-minX,0)
      | minY > worldHeight  = (0,-maxY)
      | maxY < 0            = (0,worldHeight-minY)
      | otherwise           = (0,0)





---- parsing -------

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

