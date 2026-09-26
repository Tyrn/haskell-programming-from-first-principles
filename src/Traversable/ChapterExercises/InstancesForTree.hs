module Traversable.ChapterExercises.InstancesForTree where

import Test.QuickCheck
import Test.QuickCheck.Checkers

data Tree a
    = Empty
    | Leaf a
    | Node (Tree a) a (Tree a)
    deriving (Eq, Show)

instance Functor Tree where
    fmap _ Empty = Empty
    fmap f (Leaf a) = Leaf $ f a
    fmap f (Node l a r) = Node (fmap f l) (f a) (fmap f r)

instance Foldable Tree where
    foldMap _ Empty = mempty
    foldMap f (Leaf a) = f a
    foldMap f (Node l a r) = foldMap f l <> f a <> foldMap f r

instance Traversable Tree where
    traverse f Empty = pure Empty
    traverse f (Leaf a) = Leaf <$> f a
    traverse f (Node l a r) = Node <$> traverse f l <*> f a <*> traverse f r

instance (Arbitrary a) => Arbitrary (Tree a) where
    arbitrary = sized tree
      where
        tree 0 = pure Empty
        tree n = do
            a <- arbitrary
            l <- tree (n `div` 2)
            r <- tree (n `div` 2)
            elements [Empty, Leaf a, Node l a r]

instance (Eq a) => EqProp (Tree a) where (=-=) = eq
