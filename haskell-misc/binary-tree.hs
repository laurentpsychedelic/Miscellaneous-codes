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
    where xt = mkBtree xs
          yt = mkStree xs
          xs = [ 4.5, 4, 3, 7, 2, 1, 8, 6, 5, 9 ]

data Btree a = Leaf a | ForkB (Btree a) (Btree a)
instance (Show a) => Show (Btree a) where
  show = showBtree

data Stree a = Null | ForkS (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = showStree

mkBtree :: [ a ] -> Btree a
mkBtree xs 
  | ( m == 0 ) = Leaf (unwrap xs)
  | otherwise = ForkB (mkBtree ys) (mkBtree zs)
    where m = div (length xs) 2
          ( ys, zs ) = splitAt m xs

mkStree :: Ord a => [ a ] -> Stree a
mkStree [] = Null
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
flattenS( Null ) = []
flattenS( ForkS xt x yt ) = flattenS xt ++ [ x ] ++ flattenS yt

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
showStree Null = "*"
showStree( ForkS xt x yt ) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"
