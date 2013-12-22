import System.TimeIt
import System.Random
import System.IO.Unsafe

main = do
  putStrLn( "List:\t " ++ showPartial 10 ( xs ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted xs ) )
  putStrLn( "<<Stree>>" )
  -- putStrLn( "\tTree:\t " ++ show( yt ) )
  -- putStrLn( "\tFlat:\t " ++ show( flattenS yt ) )
  timeIt( putStrLn( "\tSorted:\t " ++ showPartial 10 ( sortS xs ) ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted ys ) )
    where ys = sortS xs
          -- yt = mkStree xs
          xs = getRandomArray 100000 0 1000

getRandomArray :: Integer -> Int -> Int -> [ Int ]
getRandomArray n min max = [ getRandomNumber min max | x <- [ 1 .. n ] ]

getRandomNumber :: Int -> Int -> Int
getRandomNumber min max = unsafePerformIO( getStdRandom( randomR(min, max) ) )

showPartial :: (Show a) => Int -> [ a ] -> String
showPartial n xs = if n+1 < length xs then "[" ++ foldl append "" (take n xs) ++ ",...," ++ show(last xs) ++ "]" else show xs
  where append a b = if null a then show b else a ++ "," ++ show b
data Stree a = Null | ForkS (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = showStree

mkStree :: (Ord a) => [ a ] -> Stree a
mkStree [] = Null
mkStree( x:xs ) = ForkS (mkStree ys) x (mkStree zs)
  where ys = filter (< x) xs
        zs = filter (> x) xs

isSorted :: (Ord a) => [ a ] -> Bool
isSorted( x:y:ys ) = x < y && isSorted(y:ys)
isSorted [ x ] = True

sortS :: (Ord a) => [ a ] -> [ a ]
sortS = flattenS . mkStree

unwrap :: [ a ] -> a
unwrap [ x ] = x

wrap :: a -> [ a ]
wrap x = [ x ]

flattenS :: Stree a -> [ a ]
flattenS( Null ) = []
flattenS( ForkS xt x yt ) = flattenS xt ++ [ x ] ++ flattenS yt

showStree :: (Show a) => Stree a -> String
showStree Null = "*"
showStree( ForkS xt x yt ) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"
