import Data.List
import System.Random
import System.IO.Unsafe

main = print( calcDecay 100000 0.8 100 )

disintegrateOrNot :: Float -> Integer
disintegrateOrNot(p) = if unsafePerformIO( getStdRandom( randomR(0.0::Float, 1.0::Float) ) ) < p then 1 else 0

decay :: Float -> Integer -> Integer -> Integer
decay p m n = toInteger ( length ( filter (== 1) [ disintegrateOrNot(p) | x <- [ 1 .. m ] ] ) )
-- decay p m n = if m == 0 then 0 else ( decay p (m - 1) n ) + disintegrateOrNot(p)

calcDecay :: Integer -> Float -> Integer -> [ Integer ]
calcDecay m0 p n = scanl (decay p) m0 [ 1 .. n ]

