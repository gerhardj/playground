import System.IO
import System.Posix.Unistd

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    -- Read init information from standard input, if any
    line <- getLine
    let id = (read . ("Inid "++) $ line) :: Inidata
    loop id

data Inidata = Inid Int Int Int Int deriving (Read, Show)

loop :: Inidata -> IO ()
loop id = do
    -- Read information from standard input

    -- Compute logic here
    hPutStrLn stderr $ show id
    let (idn, dir) = finddir id
    -- hPutStrLn stderr "Debug messages..."
    
    -- Write action to standard output
    putStrLn dir
    
    loop idn

finddir :: Inidata -> (Inidata, String)
finddir (Inid lx ly tx ty) =
    (Inid lx ly (new lx tx) (new ly ty), (findns ly ty)++(findwe lx tx))
    where
        findns l t | l == t = ""
                   | l < t = "N"
                   | otherwise = "S"
        findwe l t | l == t = ""
                   | l < t = "W"
                   | otherwise = "E"
        new l t | l   < t  = t-1
                | l   > t  = t+1
                |otherwise = t
