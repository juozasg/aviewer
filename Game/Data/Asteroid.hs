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


-- screenToWorld :: Int -> GLInt -> Float
-- screenToWorld x = 

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

data WrapType = WLeft | WRight | WTop | WBottom | NoWrap deriving (Eq)

wrapWorldAsteroid :: WorldAsteroid -> WorldAsteroid
wrapWorldAsteroid wa@(as, (px,py),(vx,vy)) = (as, (nx,ny),(vx,vy))
  where
    xs = map fst $ worldAsteroidToScreen wa
    ys = map snd $ worldAsteroidToScreen wa

    (wrapType,xoffset,yoffset) = wrapParams (minimum xs) (minimum ys) (maximum xs) (maximum ys) worldWidth worldHeight
    wrapParams minX minY maxX maxY worldWidth worldHeight
         | maxX < 0            = (WLeft,maxX-px,0)
         | maxY < 0            = (WBottom,0,maxY-px) 
         | minX > worldWidth   = (WRight,px-minX,0)
         | minY > worldHeight  = (WTop,0,py-minY)
         | otherwise = (NoWrap,0,0)
    (nx, ny) = if wrapType /= NoWrap
                then wrapBoundary wrapType (px,py) (-vx,-vy) (0,0,worldHeight,worldWidth)
                else (px,py)

wrapBoundary wrapType (x,y) (vx,vy) bound@(bottom,left,top,right) =
  let dvy = y/vy
      dvx = x/vx
      intersections = [
        (WLeft, (left, y-dvx*vy)),
        (WRight, (right, y-dvx*vy)),
        (WTop, (x-dvy*vx, top)),
        (WBottom, (x-dvy*vx, bottom)),
        (NoWrap, (x,y))]
  in snd $ head $ filter (\(wt,(nx,ny)) -> wt == NoWrap || (wrapType /= wt && inBounday (nx,ny) bound)) intersections
    where inBounday (x,y) (bottom,left,top,right) = x >= left && x <= right && y >= bottom && y <= top
    
        
  -- where validIntersection (kind,(x,y)) = (x == 0 or y == 0) and ()
  
    -- just invert the velocity and find it's intersection with the edge of the world.
    -- 
    -- invertXDisplacement = (worldXCenter-centerX) * 2
    -- offsetBy minX maxX minY maxY
    --   | minX > worldWidth   = (-maxX, 0)
    --   | maxX < 0            = (worldWidth-minX,0)
    --   | minY > worldHeight  = (0,-maxY)
    --   | maxY < 0            = (0,worldHeight-minY)
    --   | otherwise           = (0,0)
    -- 




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

