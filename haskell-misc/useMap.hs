import Map( Map, buildMap, show )

main = do
  putStrLn( "List:\t " ++ show xs )
  putStrLn( "Map (original):\t " ++ show map )
    where xs = [ (1, "one"), (2, "two"), (3, "three"), (4, "four") ]
          map = buildMap xs
