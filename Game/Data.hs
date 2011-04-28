module Game.Data where

import System.Random
import Control.Applicative
import Data.Fixed

worldHeight = 1.0 :: Float
worldWidth = 1.6 :: Float

type Position = (Float, Float)
type Velocity = (Float, Float)

type Asteroid = [Position]
type Asteroids = [Asteroid]
noAsteroids = [] :: Asteroids

type WorldAsteroid = (Asteroid, Position, Velocity)
type WorldAsteroids = [WorldAsteroid]

noWorldAsteroids = [] :: WorldAsteroids


randomlyAddAsteroidToWorld :: Asteroid -> IO WorldAsteroid
randomlyAddAsteroidToWorld a = do
  p <- randomPosition
  -- v <- randomVelocity
  v <- return (0.0001, 0.0001)

  putStrLn $ "Added: " ++ show (a,p,v)
  return (a, p, v)


randomPosition :: IO Position
randomPosition = (,) <$> randomRIO (0,1.6) <*> randomRIO (0,1)

randomVelocity :: IO Velocity
randomVelocity = (,) <$> randomRIO (0,0.001) <*> randomRIO (0,0.001)


worldAsteroidToScreen :: WorldAsteroid -> Asteroid
worldAsteroidToScreen (as, (px, py), _) = map (\(x,y) -> (x+px,y+py)) as

stepWorldAsteroid ::Int -> WorldAsteroid -> WorldAsteroid
stepWorldAsteroid steps (as, (px, py), v@(vx, vy)) = wrapAroundWorldAsteroid (as, (px + vx*s, py + vy*s), v)
  where s = fromIntegral steps


wrapAroundWorldAsteroid wa@(as, (px,py),v) =
  let as = worldAsteroidToScreen wa
  in if allXOutside as
        then (as, (px `wrap` worldWidth,py), v)
        else if allYOutside as then (as, (px,py `wrap` worldHeight), v) else wa
  -- if completelyOutsideWorld $ worldAsteroidToScreen wa
  --   then (as, (px `wrap` worldWidth,py `wrap` worldHeight), v)
  --   -- then (as, (0.6, 0.5), v)
  --   else wa
  where
    wrap p limit = if p < 0 then limit + p else p - limit
    allXOutside as = and (map ((\x -> x < 0 || x > worldWidth) . fst) as)
    allYOutside as = and (map ((\y -> y < 0 || y > worldHeight) . snd) as)