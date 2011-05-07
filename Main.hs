import Data.IORef
import qualified Data.Map as Map

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Engine.Bindings
import Game.Data.All

as1 = [(0.01,0.01),(0.2,0.01),(0.2,0.2)] :: Asteroid
as2 = [(0.01,0.01),(0.01,-0.01),(-0.01,-0.01),(-0.01,0.01)] :: Asteroid

setLineSmooth :: IO ()
setLineSmooth = do
  blend $= Enabled
  lineSmooth $= Enabled
  blendFunc $= (SrcAlpha,OneMinusSrcAlpha)
  hint LineSmooth $= Nicest

main = do
  (progname, _) <- getArgsAndInitialize

  initialDisplayMode $= [DoubleBuffered]
  createWindow "Hello World"
  windowSize $= Size 480 300

  setLineSmooth

  -- basicAsteroid <- randomlyAddAsteroidToWorld as2
  -- asteroidsRef <- newIORef [basicAsteroid]

  currentTime <- get elapsedTime

  asteroidsRef <- newIORef noWorldAsteroids
  stdioBufRef <- newIORef ""
  esRef <- newIORef $ blankEventState currentTime


  keyboardMouseCallback $= Just (keyboardMouse esRef)
  reshapeCallback $= Just reshape
  idleCallback $= Just (idle asteroidsRef stdioBufRef esRef)
  displayCallback $= Just (display asteroidsRef)

  clearColor $= Color4 0.1 0.1 0.1 1.0
  mainLoop



