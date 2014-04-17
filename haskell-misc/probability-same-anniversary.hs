main = do
    sequence_ [ putStrLn( "Probability that at least two people of a group of" ++ show( n ) ++ "share the same anniversary: " ++ show( probSameAnniversary n ) ++ "%" ) | n <- [(1::Integer)..(60::Integer)] ]
-- The probability that all people in a group of N people have a different anniversary is given by 365! / (365-N)! / 365^N
-- In the program we use the fact that nPool! / (nPool-N)! = (nPool-N+1) * (nPool-N+2) * ... * nPool, to avoid calculating too big numbers

probSameAnniversary :: Integer -> Double
probSameAnniversary n = 100 * ( 1 - fromIntegral(nCasesAllDifferent 365 n) / (365 ** fromIntegral n) )

nCasesAllDifferent :: Integer -> Integer -> Integer
nCasesAllDifferent nPool n = foldr (*) 1 [ (nPool - n + 1) .. nPool ] 
