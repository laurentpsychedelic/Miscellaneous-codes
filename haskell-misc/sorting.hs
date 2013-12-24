import System.TimeIt
import System.Random
import System.IO.Unsafe
import Data.Tuple

main = do
  putStrLn( "List:\t " ++ showPartial 10 ( xs ) )
  putStrLn( "<<Stree>>" )
  timeIt( putStrLn( "\tSorted:\t " ++ showPartial 10 ( sortS xs ) ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted as ) )
  putStrLn( "Benchmark:" )
  sequence_ [ timeIt( putStrLn( (showPartial 1) ( sortS( getRandomArray n 0 1000 ) ) ) ) | n <- ns ]
  putStrLn( "<<Htree>>" )
  timeIt( putStrLn( "\tSorted:\t " ++ showPartial 10 ( sortH xs ) ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted bs ) )
  putStrLn( "Benchmark:" )
  sequence_ [ timeIt( putStrLn( (showPartial 1) ( sortH( getRandomArray n 0 1000 ) ) ) ) | n <- ns ]
  putStrLn( "<<Htree2>>" )
  timeIt( putStrLn( "\tSorted:\t " ++ showPartial 10 ( sortH2 xs ) ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted cs ) )
  putStrLn( "Benchmark:" )
  sequence_ [ timeIt( putStrLn( (showPartial 1) ( sortH2( getRandomArray n 0 1000 ) ) ) ) | n <- ns ]
  putStrLn( "<<BubbleSort>>" )
  timeIt( putStrLn( "\tSorted:\t " ++ showPartial 10 ( bubbleSort xs ) ) )
  putStrLn( "  Sorted? -> " ++ show( isSorted ds ) )
  putStrLn( "Benchmark:" )
  sequence_ [ timeIt( putStrLn( (showPartial 1) ( bubbleSort( getRandomArray n 0 1000 ) ) ) ) | n <- ns ]
    where as = sortS xs
          bs = sortH xs
          cs = sortH2 xs
          ds = bubbleSort xs
          xs = getRandomArray 1000 0 1000
          ns = [ 100,200..2000 ]

getRandomArray :: Integer -> Int -> Int -> [ Int ]
getRandomArray n min max = [ getRandomNumber min max | x <- [ 1 .. n ] ]

getRandomNumber :: Int -> Int -> Int
getRandomNumber min max = unsafePerformIO( getStdRandom( randomR(min, max) ) )

showPartial :: (Show a) => Int -> [ a ] -> String
showPartial 0 xs = "[...]"
showPartial 1 xs = "[" ++ show(head xs) ++ ",...]"
showPartial n xs = if n+1 < length xs then "[" ++ foldl append "" (take n xs) ++ ",...," ++ show(last xs) ++ "]" else show xs
  where append a b = if null a then show b else a ++ "," ++ show b
data Stree a = Null | ForkS (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = showStree

data Htree a = NullH | ForkH a (Htree a) (Htree a)
instance (Show a) => Show (Htree a) where
  show = showHtree

mkStree :: (Ord a) => [ a ] -> Stree a
mkStree [] = Null
mkStree( x:xs ) = ForkS (mkStree ys) x (mkStree zs)
  where ys = filter (< x) xs
        zs = filter (> x) xs

mkHtree :: [ a ] -> Htree a
mkHtree xs
  | null xs = NullH
  | null ts = ForkH (unwrap x) NullH NullH 
  | otherwise = ForkH (unwrap x) (mkHtree ys) (mkHtree zs)
    where m = div (length ts) 2
          ( ys, zs ) = splitAt m ts
          ( x, ts ) = splitAt 1 xs 

mkHtree2 :: (Ord a) => [ a ] -> Htree a
mkHtree2 = head . mkHtrees . levels

mkHtrees :: (Ord a) => [ [ a ] ] -> [ Htree a ]
mkHtrees = foldr addLayer [ NullH ]

addLayer :: (Ord a) => [ a ] -> [ Htree a ] -> [ Htree a ]
addLayer [] zt = []
addLayer (x:xs) (y:z:zts) = wrap (ForkH x y z) ++ addLayer xs zts
addLayer (x:xs) (z:zts) = wrap (ForkH x z NullH) ++ addLayer xs zts
addLayer (x:xs) [] = wrap (ForkH x NullH NullH) ++ addLayer xs []

levels :: [ a ] -> [ [ a ] ]
levels = levelsWith 1

levelsWith :: Int -> [ a ] -> [ [ a ] ]
levelsWith n xs = if n < length xs then wrap ys ++ levelsWith (2 * n) zs else wrap ys
  where (ys, zs) = splitAt n xs

mkHeap :: (Ord a) => [ a ] -> Htree a
mkHeap = heapify . mkHtree

mkHeap2 :: (Ord a) => [ a ] -> Htree a
mkHeap2 = heapify . mkHtree2

heapify :: (Ord a) => Htree a -> Htree a
heapify NullH = NullH 
heapify( ForkH x xt yt ) = doPermutationsH x (heapify xt) (heapify yt)

doPermutationsH :: (Ord a) => a -> Htree a -> Htree a -> Htree a
doPermutationsH x NullH NullH = ForkH x NullH NullH
doPermutationsH x NullH (ForkH y yt zt) = if x <= y then ForkH x NullH (ForkH y yt zt) else ForkH y NullH (doPermutationsH x yt zt)
doPermutationsH x (ForkH y yt zt) NullH = if x <= y then ForkH x (ForkH y yt zt) NullH else ForkH y (doPermutationsH x yt zt) NullH
doPermutationsH x (ForkH y yt zt) (ForkH z mt nt)
  | x <= min y z = ForkH x (ForkH y yt zt) (ForkH z mt nt)
  | y <= min x z = ForkH y (doPermutationsH x yt zt) (ForkH z mt nt)
  | z <= min x y = ForkH z (ForkH y yt zt) (doPermutationsH x mt nt)

isSorted :: (Ord a) => [ a ] -> Bool
isSorted( x:y:ys ) = if sorted then sorted else error "Not sorted!"
  where sorted = x <= y && isSorted(y:ys)
isSorted [ x ] = True

sortS :: (Ord a) => [ a ] -> [ a ]
sortS = flattenS . mkStree

sortH :: (Ord a) => [ a ] -> [ a ]
sortH = flattenH . mkHeap

sortH2 :: (Ord a) => [ a ] -> [ a ]
sortH2 = flattenH . mkHeap2

bubbleSort :: (Ord a) => [ a ] -> [ a ]
bubbleSort [] = []
bubbleSort( xs ) = bubbleSort( zs ) ++ z
  where (zs, z) = splitAt (length ys - 1) ys
        ys = doPermutations( xs )

doPermutations :: (Ord a) => [ a ] -> [ a ]
doPermutations( x:y:ys ) = if x > y then y:doPermutations(x:ys) else x:doPermutations(y:ys)
doPermutations( x:[] ) = [ x ]

unwrap :: [ a ] -> a
unwrap [ x ] = x

wrap :: a -> [ a ]
wrap x = [ x ]

flattenS :: Stree a -> [ a ]
flattenS( Null ) = []
flattenS( ForkS xt x yt ) = flattenS xt ++ [ x ] ++ flattenS yt

flattenH :: (Ord a) => Htree a -> [ a ]
flattenH( NullH ) = []
flattenH( ForkH x yt zt ) = wrap x ++ merge (flattenH yt) (flattenH zt)

merge :: (Ord a) => [ a ] -> [ a ] -> [ a ]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) =
  if x <= y then wrap x ++ merge xs (y:ys) else wrap y ++ merge (x:xs) ys

showStree :: (Show a) => Stree a -> String
showStree Null = "*"
showStree( ForkS xt x yt ) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"

showHtree :: (Show a) => Htree a -> String
showHtree NullH = "*"
showHtree( ForkH x xt yt ) = "(" ++ show(x) ++ ":" ++ showHtree(xt) ++ "," ++ showHtree(yt) ++ ")"
