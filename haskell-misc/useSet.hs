import Set( Set, buildSet, showAsTree, insert )

main = do
  putStrLn( "List:\t " ++ show xs )
  putStrLn( "Set :\t " ++ (show . insert 10) xt )
  putStrLn( "Tree:\n" ++ showAsTree xt )
    where xt = buildSet xs
          xs = [ 5, 4, 3, 8, 2, 1, 9, 7, 6 ]
