main = do
  putStrLn( "List:\t " ++ show( xs ) )
  putStrLn( "Tree:\t " ++ show( xt ) )
  putStrLn( "Flat:\t " ++ show( flatten xt ) )
  putStrLn( "Size:\t " ++ show( size xt ) )
  putStrLn( "Size2:\t " ++ show( size2 xt ) )
  putStrLn( "Height:\t " ++ show( height xt ) )
    where xt = mkBtree xs
          xs = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

data Btree a = Leaf a | Fork (Btree a) (Btree a)
instance (Show a) => Show (Btree a) where
  show = showBtree

mkBtree :: [ a ] -> Btree a
mkBtree xs 
  | ( m == 0 ) = Leaf (unwrap xs)
  | otherwise = Fork (mkBtree ys) (mkBtree zs)
    where m = div (length xs) 2
          ( ys, zs ) = splitAt m xs

unwrap :: [ a ] -> a
unwrap [ x ] = x

flatten :: Btree a -> [ a ]
flatten( Leaf x ) = [ x ]
flatten( Fork xt yt ) = flatten xt ++ flatten yt

size :: Btree a -> Int
size( Leaf x ) = 1
size( Fork xt yt ) = size xt + size yt

size2 :: Btree a -> Int
size2 = length . flatten

height :: Btree a -> Int
height( Leaf x ) = 0
height( Fork xt yt ) = 1 + max (height xt) (height yt)

showBtree :: (Show a) => Btree a -> String
showBtree( Leaf x ) = show(x)
showBtree( Fork xt yt ) = "(" ++ showBtree(xt) ++ "," ++ showBtree(yt) ++ ")"
