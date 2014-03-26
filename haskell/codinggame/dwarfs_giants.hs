-- Read inputs from Standard Input
-- Write outputs to Standard Output
import Control.Monad
import qualified Data.Map as Map

main :: IO ()
main = do
    n <- readLn :: IO Int
    foo <- replicateM n getLine
    let m = linestomap foo
    putStrLn . show . traverseAll $ m
    --putStrLn . unlines $ foo

linestomap :: [String] -> (Map.Map Int [Int])
linestomap = foldl ( addtomap) Map.empty . map ((\[a,b]->(a,b)) . map read . words)
--linestomap = foldl (flip (Map.insertWith (++))) Map.empty . map ((\[a,b]->(a,[b])) . map read . words)

addtomap :: (Map.Map Int [Int]) -> (Int,Int) -> (Map.Map Int [Int])
addtomap m (a,b) =
    Map.insert a (b:newk) m
    where
    newk :: [Int]
    newk = Map.findWithDefault [] a m

traverse :: Int -> (Map.Map Int [Int]) -> Int
traverse k m = 1 + maximum (pathcosts paths)
    where
    paths = Map.findWithDefault [] k m
    pathcosts [] = [0]
    pathcosts l = map (\nk -> traverse nk m) l

traverseAll :: (Map.Map Int [Int]) -> Int
traverseAll m = maximum results
    where
    results = map (flip traverse $ m) allkeys
    allkeys = Map.keys m
