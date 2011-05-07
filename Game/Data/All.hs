module Game.Data.All where

import Game.Data.Asteroid
import Game.Data.EventState

type Position = (Float, Float)
type Velocity = (Float, Float)

worldHeight = 1.0 :: Float
worldWidth = 1.6 :: Float

worldYCenter = worldHeight / 2
worldXCenter = worldWidth / 2

