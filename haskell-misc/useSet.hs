import Set( Set, buildSet, showAsTree, insert, remove, contains )

main = do
  putStrLn( "List:\t " ++ show xs )
  putStrLn( "Set (original):\t " ++ show xt )
  putStrLn( "Contains 8? => " ++ show( contains 8 xt ) )
  putStrLn( "Contains 2? => " ++ show( contains 2 xt ) )
  putStrLn( "Tree (original):\n" ++ showAsTree xt )
  putStrLn( "Set (+[2]):\t " ++ show at )
  putStrLn( "Tree (+[2]):\n" ++ showAsTree at )
  putStrLn( "Set (+[2]-[5]):\t " ++ show bt )
  putStrLn( "Tree (+[2]-[5]):\n" ++ showAsTree bt )
    where xs  = [ 5, 4, 3, 8, 1, 9, 7, 6 ]
          xt  = buildSet xs
          at = insert 2 xt
          bt = remove 5 at
