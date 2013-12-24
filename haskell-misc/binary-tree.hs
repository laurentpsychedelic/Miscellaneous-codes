main = do
  putStrLn( "List:\t " ++ show( xs ) )
  putStrLn( "<<Btree>>" )
  putStrLn( "\tTree:\t " ++ show( xt ) )
  putStrLn( "\tFlat:\t " ++ show( flattenB xt ) )
  putStrLn( "\tSize:\t " ++ show( size xt ) )
  putStrLn( "\tSize2:\t " ++ show( size2 xt ) )
  putStrLn( "\tHeight:\t " ++ show( height xt ) )
  putStrLn( "<<Stree>>" )
  putStrLn( "\tTree:\t " ++ show( yt ) )
  putStrLn( "\tFlat:\t " ++ show( flattenS yt ) )
  putStrLn( "\tSorted:\t " ++ show( sortS xs ) )
  putStrLn( "<<Htree>>")
  putStrLn( "\tTree:\t " ++ show( zt ) )
  putStrLn( "\tFlat:\t " ++ show( flattenH zt ) )
    where xt = mkBtree xs
          yt = mkStree xs
          zt = mkHeap  xs
          xs = [ 4.5, 4, 3, 7, 2, 1, 8, 6, 5, 9 ]

data Btree a = Leaf a | ForkB (Btree a) (Btree a)
instance (Show a) => Show (Btree a) where
  show = showBtree

data Stree a = NullS | ForkS (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = showStree

data Htree a = NullH | ForkH a (Htree a) (Htree a)
instance (Show a) => Show (Htree a) where
  show = showHtree

mkBtree :: [ a ] -> Btree a
mkBtree xs 
  | ( m == 0 ) = Leaf (unwrap xs)
  | otherwise = ForkB (mkBtree ys) (mkBtree zs)
    where m = div (length xs) 2
          ( ys, zs ) = splitAt m xs

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

mkStree :: Ord a => [ a ] -> Stree a
mkStree [] = NullS
mkStree( x:xs ) = ForkS (mkStree ys) x (mkStree zs)
  where ys = filter (< x) xs
        zs = filter (> x) xs

sortS :: Ord a => [ a ] -> [ a ]
sortS = flattenS . mkStree

unwrap :: [ a ] -> a
unwrap [ x ] = x

wrap :: a -> [ a ]
wrap x = [ x ]

flattenB :: Btree a -> [ a ]
flattenB( Leaf x ) = [ x ]
flattenB( ForkB xt yt ) = flattenB xt ++ flattenB yt

flattenS :: Stree a -> [ a ]
flattenS( NullS ) = []
flattenS( ForkS xt x yt ) = flattenS xt ++ [ x ] ++ flattenS yt

flattenH :: (Ord a) => Htree a -> [ a ]
flattenH( NullH ) = []
flattenH( ForkH x yt zt ) = wrap x ++ merge (flattenH yt) (flattenH zt)

merge :: (Ord a) => [ a ] -> [ a ] -> [ a ]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) =
  if x <= y then wrap x ++ merge xs (y:ys) else wrap y ++ merge (x:xs) ys

size :: Btree a -> Int
size( Leaf x ) = 1
size( ForkB xt yt ) = size xt + size yt

size2 :: Btree a -> Int
size2 = length . flattenB

height :: Btree a -> Int
height( Leaf x ) = 0
height( ForkB xt yt ) = 1 + max (height xt) (height yt)

showBtree :: (Show a) => Btree a -> String
showBtree( Leaf x ) = show(x)
showBtree( ForkB xt yt ) = "(" ++ showBtree(xt) ++ "," ++ showBtree(yt) ++ ")"

showStree :: (Show a) => Stree a -> String
showStree NullS = "*"
showStree( ForkS xt x yt ) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"

showHtree :: (Show a) => Htree a -> String
showHtree NullH = "*"
showHtree( ForkH x xt yt ) = "(" ++ show(x) ++ ":" ++ showHtree(xt) ++ "," ++ showHtree(yt) ++ ")"
