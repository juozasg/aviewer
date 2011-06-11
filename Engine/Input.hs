module Engine.Input (keyboardMouse) where

import Game.Core

keyboardMouse bsRef k ks m p = registerEvent bsRef (k,ks,m,p)
