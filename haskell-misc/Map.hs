module Map ( Map, show, buildMap, contains ) where
import Set ( Set, show, buildSet, insert, remove, contains )

data KeyValue a b = Pair a b
instance (Ord a) => Eq (KeyValue a b) where
  Pair x y == Pair s t = x Prelude.== s
instance (Ord a) => Ord (KeyValue a b) where
  Pair x y < Pair s t = x < s
instance (Show a, Show b) => Show (KeyValue a b) where
  show (Pair x y) = show x ++ "=>" ++ show  y

(==) :: (Eq a) => a -> KeyValue a b -> Bool
x == Pair y z = x Prelude.== y

type Map a b = Set (KeyValue a b)

instance (Show a, Show b) => Show (Map a b) where
show :: (Show a, Show b) => Map a b -> String
show map = Set.show map

buildMap :: (Ord a) => [ (a, b) ] -> Map a b
buildMap = buildSet . (map makePair)

makePair :: (a, b) -> KeyValue a b
makePair (a, b) = Pair a b
