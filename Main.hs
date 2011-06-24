import Data.IORef
import qualified Data.Map as Map

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Engine.Bindings
import Game.Data.Asteroid
import Game.Data.EventState
import Game.Data.BigState

as1 = [(0.01,0.01),(0.2,0.01),(0.2,0.2)] :: Asteroid
as2 = [(0.01,0.01),(0.01,-0.01),(-0.01,-0.01),(-0.01,0.01)] :: Asteroid

setLineSmooth :: IO ()
setLineSmooth = do
  blend $= Enabled
  lineSmooth $= Enabled
  blendFunc $= (SrcAlpha,OneMinusSrcAlpha)
  hint LineSmooth $= Nicest

main = do
  let screenX = 480
      screenY = 300
  (progname, _) <- getArgsAndInitialize

  initialDisplayMode $= [DoubleBuffered]
  createWindow "Hello World"
  windowSize $= Size screenX screenY

  setLineSmooth

  basicAsteroid <- randomlyAddAsteroidToWorld as2
  -- asteroidsRef <- newIORef [basicAsteroid]

  currentTime <- get elapsedTime

  -- asteroidsRef <- newIORef noWorldAsteroids
  stdioBufRef <- newIORef ""
  -- esRef <- newIORef $ blankEventState currentTime

  bigStateRef <- newIORef $ BigState (blankEventState currentTime) [] stdioBufRef (fromIntegral screenX, fromIntegral screenY)

  keyboardMouseCallback $= Just (keyboardMouse bigStateRef)
  passiveMotionCallback $= Just (mouseMotion bigStateRef)
  motionCallback $= Just (mouseMotion bigStateRef)

  reshapeCallback $= Just (reshape bigStateRef)
  idleCallback $= Just (idle bigStateRef)
  displayCallback $= (display bigStateRef)

  clearColor $= Color4 0.1 0.1 0.1 1.0
  mainLoop



