module GenApplicativeSpec (main, spec) where

import Test.Hspec
import Language.Haskell.Refact.Refactoring.GenApplicative
import System.Directory
import TestUtils

main :: IO ()
main = do
  hspec spec

spec :: Spec
spec = do
  describe "doGenApplicative" $ do
    it "Simple parser that can be easily rewritten in the applicative style."
      res <- ct $ genApplicative defaultTestSettings testOptions "./GenApplicative/GA1.hs" "parseStr"
      res' <- ct $ mapM makeRelativeToCurrentDirectory res
      res' `shouldBe` ["GenApplicative/GA1.hs"]
      diff <- ct $ compareFiles "./GenApplicative/GA1.refactored.hs"
                                "./GenApplicative/GA1.hs.expected"