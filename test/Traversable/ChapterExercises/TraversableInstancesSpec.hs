module Traversable.ChapterExercises.TraversableInstancesSpec where

import Test.Hspec
import Test.Hspec.Checkers
import Test.QuickCheck
import Test.QuickCheck.Classes
import Traversable.ChapterExercises.TraversableInstances

spec :: Spec
spec = do
    -- testBatch $ traversable (undefined :: Identity (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: Constant Int (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: Optional (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: List (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: Three Int Int (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: Three' Int (Maybe Int, [Int], Int, [Int]))
    -- testBatch $ traversable (undefined :: S [] (Maybe Int, [Int], Int, [Int]))
    testBatch $ traversable (undefined :: Identity (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: Constant Int (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: Optional (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: List (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: Three Int Int (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: Three' Int (Maybe Int, Maybe Int, Int, [Int]))
    testBatch $ traversable (undefined :: S [] (Maybe Int, Maybe Int, Int, [Int]))
