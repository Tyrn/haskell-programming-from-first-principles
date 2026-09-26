module State.ThrowDown.ExercisesSpec where

import State.ThrowDown.Exercises
import System.Random
import Test.Hspec

spec :: Spec
spec = do
    describe "Test rollsToGetN" $ do
        it "roolsToGetN 20" $ do
            rollsToGetN 20 (mkStdGen 0) `shouldBe` 8
    describe "Test rollsCountLogged" $ do
        it "rollsCountLogged 20" $ do
            rollsCountLogged 20 (mkStdGen 0) `shouldBe` (8, [DieTwo, DieOne, DieSix, DieFive, DieFour, DieOne, DieOne, DieOne])
