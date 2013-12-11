import Data.List
import Text.Regex
import Data.Tuple

main = do
  putStrLn(show(process "directory,file1,file2,file3"))

process :: String -> String
process s = foldl join "" ( repair( pair (head, tail) ( disjoin s ) ) )

repair :: (String, [String]) -> [String]
repair x = map (appendHead (fst x)) (snd x)

appendHead :: String -> String -> String
appendHead h x = h ++ "/" ++ x

pair :: (a -> b, a -> d) -> a -> (b, d)
pair (f, g) x = (f x, g x)

join :: String -> String -> String
join x y = if null x then y else x ++ "|" ++ y

disjoin :: String -> [ String ]
disjoin = splitRegex (mkRegex ",")

