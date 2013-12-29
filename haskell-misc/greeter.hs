main = do
  great "mec"

great :: String -> IO()
great name = putStrLn ("Hello " ++ name ++ "!!")
