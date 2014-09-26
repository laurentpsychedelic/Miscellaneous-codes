module Set( Set, buildSet, show, showAsTree, insert, remove, contains ) where

type Set a = Stree a

data Stree a = Null | Fork (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = show . flatten

showAsTree :: (Show a) => Stree a -> String
showAsTree xt = showStree2 xt (valueWidth xt) None

buildSet :: Ord a => [ a ] -> Set a
buildSet = mkStree

insert :: Ord a => a -> Stree a -> Stree a
insert a Null = Fork Null a Null
insert a (Fork xt x yt)
  | a == x = Fork xt x yt
  | a < x  = Fork (insert a xt) x yt
  | a > x  = Fork xt x (insert a yt)

remove :: Ord a => a -> Stree a -> Stree a
remove a Null = Null
remove a (Fork xt x yt)
  | a < x = Fork (remove a xt) x yt
  | a > x = Fork xt x (remove a yt)
  | a == x = mergeTrees xt yt

mergeTrees :: (Ord a) => Stree a -> Stree a -> Stree a
mergeTrees xt Null = xt
mergeTrees Null yt = yt
mergeTrees xt yt = Fork xt l zt
  where (l, zt) = deleteLeast yt

deleteLeast :: (Ord a) => Stree a -> (a, Stree a)
deleteLeast (Fork Null x Null) = (x, Null)
deleteLeast (Fork xt x yt) = (l, Fork zt x yt)
  where (l, zt) = deleteLeast xt

contains :: Ord a => a -> Stree a -> Bool
contains a Null = False
contains a (Fork xt x yt)
  | a == x = True
  | otherwise = if contains a xt then True else contains a yt

mkStree :: Ord a => [ a ] -> Stree a
mkStree [] = Null
mkStree( x:xs ) = Fork (mkStree ys) x (mkStree zs)
  where ys = filter (< x) xs
        zs = filter (> x) xs

sort :: Ord a => [ a ] -> [ a ]
sort = flatten . mkStree

unwrap :: [ a ] -> a
unwrap [ x ] = x

wrap :: a -> [ a ]
wrap x = [ x ]

flatten :: Stree a -> [ a ]
flatten (Null) = []
flatten (Fork xt x yt) = flatten xt ++ [ x ] ++ flatten yt

size :: Stree a -> Int
size (Null) = 0
size (Fork xt x yt) = 1 + size xt + size yt


height :: Stree a -> Int
height Null = 0
height (Fork xt x yt) = 1 + max (height xt) (height yt)

showStree :: (Show a) => Stree a -> String
showStree Null = "*"
showStree (Fork Null x Null) = "(" ++ show(x) ++ ")"
showStree (Fork xt x yt) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"


valueWidth :: (Show a) => Stree a -> Int
valueWidth Null = 0
valueWidth (Fork xt x yt) = max (width x + 2) (max (valueWidth xt) (valueWidth yt))
  where width = length . show

spaceWidth :: Int
spaceWidth = 1

connector :: Char
connector = '─'

showStreePicture :: (Show a) => Stree a -> String
showStreePicture xt = showStree2 xt (valueWidth xt) None

data Dir = None | LeftNode | RightNode
        deriving (Eq, Enum)

showStree2 :: (Show a) => Stree a -> Int -> Dir -> String
showStree2 (Fork Null x Null) maxLength dir = header ++
                                                 showValue x maxLength
  where left = div maxLength 2
        right = maxLength - left
        header = if dir == None then "" else
                   ( if dir == LeftNode then ( getSpaces left ++ getSequence connector right ) else ( getSequence connector left ++ getSpaces right ) ) ++ "\n"

showStree2 (Fork Null x yt) maxLength dir = header ++
                                              showValue x maxLength ++ getSpaces right ++ "\n" ++
                                              mergeLines s t (getSpaces ls) (getSpaces lt)
  where ls = div maxLength 2
        s = getSpaces ls
        t = showStree2 yt maxLength RightNode
        lt = widthLines t
        right = ls + lt + spaceWidth - maxLength
        len = div maxLength 2
        header = if dir == None then "" else
                   ( if dir == LeftNode then ( getSpaces len ++ getSequence connector (maxLength + right - len) ) else ( getSequence connector len ++ getSpaces (maxLength - len) ) ) ++ "\n"
showStree2 (Fork xt x Null) maxLength dir = header ++
                                              getSpaces left ++ showValue x maxLength ++ "\n" ++
                                              mergeLines s t (getSpaces ls) (getSpaces lt)
  where s = showStree2 xt maxLength LeftNode
        lt = div maxLength 2
        t = getSpaces lt
        ls = widthLines s
        left = ls - lt
        len = div maxLength 2
        header = if dir == None then "" else ( if dir == LeftNode then ( getSpaces (left + len) ++ getSequence connector (maxLength - len) ) else ( getSequence connector (left + len) ++ getSpaces (maxLength - len) ) ) ++ "\n"
showStree2 (Fork xt x yt) maxLength dir = header ++
                                           getSpaces left ++ showValue x maxLength ++ getSpaces right ++ "\n" ++
                                           mergeLines s t (getSpaces ls) (getSpaces lt)
  where s = showStree2 xt maxLength LeftNode
        t = showStree2 yt maxLength RightNode
        ls = widthLines s
        lt = widthLines t
        len = div maxLength 2
        left = ls - len
        right = ls + lt + spaceWidth - left - maxLength
        header = if dir == None then "" else ( if dir == LeftNode then ( getSpaces (left + len) ++ getSequence connector (maxLength + right - len) ) else ( getSequence connector (left + len) ++ getSpaces (lt + spaceWidth) ) ) ++ "\n"

widthLines :: String -> Int
widthLines str = maximum (map length (lines str))

showValue :: (Show a) => a -> Int -> String
showValue a maxLength = "[" ++ if length s - 2 >= len then s else getSpaces (div (len - length s) 2) ++ s ++ getSpaces (len - (div (len - length s) 2) - length s) ++ "]"
  where s = show(a)
        len = maxLength - 2

getSpaces :: Int -> String
getSpaces = getSequence ' '

getSequence :: Char -> Int -> String
getSequence c n = [ c | s <- [1..n] ] 

mergeLines :: String -> String -> String -> String -> String
mergeLines s t defaultLineLeft defaultLineRight = foldr (curry joinNewLine) "" (map joinSpace (zipp defaultLineLeft defaultLineRight (lines s) (lines t)))
  where joinSpace (a, b) = a ++ getSequence ' ' spaceWidth ++ b
        joinNewLine (a, b) = a ++ "\n" ++ b
        zipp dl dr x y = if length x < length y then zip (x ++ [ dl | n <- [1..(length y - length x)] ]) y else zip x (y ++ [ dr | n <- [1..(length x - length y)] ])
