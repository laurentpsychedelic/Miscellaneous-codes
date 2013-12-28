main = do
  putStrLn( "List:\t " ++ show xs )
  putStrLn( "Tree:\n" ++ show xt )
    where xt = mkStree xs
          xs = [ 5, 4, 3, 8, 2, 1, 9, 7, 6 ]

data Stree a = NullS | ForkS (Stree a) a (Stree a)
instance (Show a) => Show (Stree a) where
  show = showStreePicture

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

flattenS :: Stree a -> [ a ]
flattenS (NullS) = []
flattenS (ForkS xt x yt) = flattenS xt ++ [ x ] ++ flattenS yt

sizeS :: Stree a -> Int
sizeS (NullS) = 0
sizeS (ForkS xt x yt) = 1 + sizeS xt + sizeS yt


heightS :: Stree a -> Int
heightS NullS = 0
heightS (ForkS xt x yt) = 1 + max (heightS xt) (heightS yt)

showStree :: (Show a) => Stree a -> String
showStree NullS = "*"
showStree (ForkS NullS x NullS) = "(" ++ show(x) ++ ")"
showStree (ForkS xt x yt) = "(" ++ show(x) ++ ":" ++ showStree(xt) ++ "," ++ showStree(yt) ++ ")"


valueWidth :: (Show a) => Stree a -> Int
valueWidth NullS = 0
valueWidth (ForkS xt x yt) = max (width x + 2) (max (valueWidth xt) (valueWidth yt))
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
showStree2 (ForkS NullS x NullS) maxLength dir = header ++
                                                 showValue x maxLength
  where left = div maxLength 2
        right = maxLength - left
        header = if dir == None then "" else
                   ( if dir == LeftNode then ( getSpaces left ++ getSequence connector right ) else ( getSequence connector left ++ getSpaces right ) ) ++ "\n"

showStree2 (ForkS NullS x yt) maxLength dir = header ++
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
showStree2 (ForkS xt x NullS) maxLength dir = header ++
                                              getSpaces left ++ showValue x maxLength ++ "\n" ++
                                              mergeLines s t (getSpaces ls) (getSpaces lt)
  where s = showStree2 xt maxLength LeftNode
        lt = div maxLength 2
        t = getSpaces lt
        ls = widthLines s
        left = ls - lt
        len = div maxLength 2
        header = if dir == None then "" else ( if dir == LeftNode then ( getSpaces (left + len) ++ getSequence connector (maxLength - len) ) else ( getSequence connector (left + len) ++ getSpaces (maxLength - len) ) ) ++ "\n"
showStree2 (ForkS xt x yt) maxLength dir = header ++
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
