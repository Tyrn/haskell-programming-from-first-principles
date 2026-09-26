module Traversable.ChapterExercises.InstancesForTreeSpec where

import Test.Hspec
import Test.Hspec.Checkers
import Test.QuickCheck
import Test.QuickCheck.Classes
import Traversable.ChapterExercises.InstancesForTree

spec :: Spec
spec = do
    testBatch $ traversable (undefined :: Tree (Maybe Int, Maybe Int, Int, [Int]))
