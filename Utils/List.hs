module Utils.List where

import Data.List

median :: Ord a => [a] -> a
median xs = (sort xs) !! ((length xs) `div` 2)

