module Main where

import System.Random
import Data.List
import Data.Char

main :: IO ()
main = do
    putStrLn $ (randomstring 906230920) ++ " " ++ (randomstring 13272039)
    return ()


randomstring :: Int -> String
randomstring seed = r_ gen
    where
    gen = mkStdGen seed
    r_ g = maybe [] (:r_ gn) letter
        where
        (i, gn) = next g
        cropped = i `mod` 27
        letter = case cropped of
            0 -> Nothing
            _ -> Just . chr $ 96 + cropped

brute t f inf = 
    find ((==t) . snd) $ execd
    where
    execd = map (\z -> (z, f z)) inf

-- vim: set: ts=4
